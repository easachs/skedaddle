# frozen_string_literal: true

class PlaceService
  class << self
    def near(location = {}, group = '', radius = 5_000)
      return unless location.is_a?(Hash) && location.present? && group.present?

      Rails.cache.fetch("place/#{group}/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = conn.post('/v1/places:searchNearby') do |route|
          route.body = payload(location, group, radius)
        end
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def payload(location, group, radius)
      return unless location.is_a?(Hash) && location.present?
      return if group.blank?

      { includedTypes: [group],
        maxResultCount: 5,
        locationRestriction: { circle: { center: {
                                           latitude: location[:lat],
                                           longitude: location[:lon]
                                         },
                                         radius: } } }.to_json
    end

    def conn
      Faraday.new(url: 'https://places.googleapis.com') do |route|
        route.headers.merge!(
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': ENV.fetch('GOOGLE_MAPS_KEY', nil),
          'X-Goog-FieldMask': 'places.formattedAddress,places.displayName'
        )
      end
    end
  end
end
