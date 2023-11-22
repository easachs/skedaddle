# frozen_string_literal: true

class PlaceService
  class << self
    def near(location = {}, main = '', radius = 5000)
      return unless location.is_a?(Hash) && location.present? && main.present?

      Rails.cache.fetch("PlaceService/#{main}/near/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = conn.post('/v1/places:searchNearby') do |route|
          route.headers['X-Goog-FieldMask'] = 'places.formattedAddress,places.displayName'
          route.body = payload(location, main, radius)
        end
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def payload(location, main, radius)
      return unless location.is_a?(Hash) && location.present?
      return if main.blank?

      { includedTypes: [main],
        maxResultCount: 5,
        locationRestriction: { circle: { center: {
                                           latitude: location[:lat],
                                           longitude: location[:lon]
                                         },
                                         radius: } } }.to_json
    end

    def conn
      Faraday.new(url: 'https://places.googleapis.com') do |f|
        f.headers['Content-Type'] = 'application/json'
        f.headers['X-Goog-Api-Key'] = ENV.fetch('GOOGLE_MAPS_KEY', nil)
      end
    end
  end
end
