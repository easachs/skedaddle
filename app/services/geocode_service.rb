# frozen_string_literal: true

class GeocodeService
  class << self
    def geocode(location = '')
      return if location.blank?

      Rails.cache.fetch("GeocodeService/geocode/#{location}", expires_in: 1.hour) do
        response = conn.get('/v1/forward') do |route|
          route.params['query'] = location
        end
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def conn
      Faraday.new(url: 'http://api.positionstack.com') do |f|
        f.params['access_key'] = ENV.fetch('GEOCODE_API_KEY', nil)
      end
    end
  end
end
