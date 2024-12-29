# frozen_string_literal: true

class GeocodeService
  class << self
    def geocode(location = '')
      return if location.blank?

      query = I18n.transliterate(location)
      Rails.cache.fetch("geocode/#{location}", expires_in: 1.hour) do
        response = conn.get("/maps/api/geocode/json?address=#{query}").body
        JSON.parse(response, symbolize_names: true)
      end
    end

    private

    def conn
      Faraday.new(url: 'https://maps.googleapis.com') do |route|
        route.params[:key] = ENV.fetch('GOOGLE_MAPS_KEY', nil)
      end
    end
  end
end
