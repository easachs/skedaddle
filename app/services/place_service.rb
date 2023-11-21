# frozen_string_literal: true

class PlaceService
  class << self
    def near(location = {}, main = '', radius = 5000)
      return unless location.is_a?(Hash) && location.present? && main.present?

      cache_key = "PlaceService/#{main}/near/#{location[:lat]}/#{location[:lon]}"
      Rails.cache.fetch(cache_key, expires_in: 7.days) do
        response = conn.get('/maps/api/place/nearbysearch/json') do |route|
          route.params['type'] = main
          route.params['location'] = "#{location[:lat]}, #{location[:lon]}"
          route.params['radius'] = radius
        end
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    def near_new(location = {}, main = '', radius = 5000)
      return unless location.is_a?(Hash) && location.present? && main.present?

      cache_key = "PlaceService/#{main}/near/#{location[:lat]}/#{location[:lon]}"
      Rails.cache.fetch(cache_key, expires_in: 7.days) do
        response = conn_new.post('/v1/places:searchNearby') do |route|
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
      Faraday.new(url: 'https://maps.googleapis.com') do |f|
        f.params['key'] = ENV.fetch('GOOGLE_MAPS_KEY', nil)
      end
    end

    def conn_new
      Faraday.new(url: 'https://places.googleapis.com') do |f|
        f.headers['Content-Type'] = 'application/json'
        f.headers['X-Goog-Api-Key'] = ENV.fetch('GOOGLE_MAPS_KEY', nil)
      end
    end
  end
end
