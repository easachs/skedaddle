# frozen_string_literal: true

class PlacesService
  def self.places_near(location = {}, main = '')
    return unless location.is_a?(Hash) && location.present?
    return if main.blank?

    cache_key = "PlacesService/places_near/#{main}/#{location[:lat]}/#{location[:lon]}"
    Rails.cache.fetch(cache_key, expires_in: 7.days) do
      response = conn.post('/v1/places:searchNearby') do |route|
        route.headers['X-Goog-FieldMask'] = 'places.formattedAddress,places.displayName'
        route.body = payload(location, main).to_json
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.payload(location = {}, main = '')
    return unless location.is_a?(Hash) && location.present?
    return if main.blank?

    { includedTypes: [main],
      maxResultCount: 5,
      locationRestriction: { circle: { center: {
                                         latitude: location[:lat],
                                         longitude: location[:lon]
                                       },
                                       radius: 5000 } } }
  end

  def self.conn
    Faraday.new(url: 'https://places.googleapis.com') do |f|
      f.headers['Content-Type'] = 'application/json'
      f.headers['X-Goog-Api-Key'] = ENV.fetch('GOOGLE_MAPS_KEY', nil)
    end
  end
end
