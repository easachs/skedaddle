# frozen_string_literal: true

class GeocodeService
  class << self
    def geocode(location = '')
      return if location.blank?

      Rails.cache.fetch("geocode/#{location}", expires_in: 1.hour) do
        response = conn.get("/v1/forward?query=#{location}").body
        parsed = JSON.parse(response, symbolize_names: true)
        parsed.keys.include?(:error) ? nil : parsed
      end
    end

    private

    def conn
      Faraday.new(url: 'http://api.positionstack.com') do |route|
        route.params[:access_key] = ENV.fetch('GEOCODE_API_KEY', nil)
      end
    end
  end
end
