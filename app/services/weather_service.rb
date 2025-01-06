# frozen_string_literal: true

class WeatherService
  class << self
    def forecast(location = nil)
      return if location.blank? || !location.is_a?(Hash)

      Rails.cache.fetch("weather/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = fetch_weather(location).body
        JSON.parse(response, symbolize_names: true)
      end
    end

    private

    def fetch_weather(location)
      conn.get('forecast') do |route|
        route.params.merge!(
          lat: location[:lat],
          lon: location[:lon],
          units: 'imperial'
        )
      end
    end

    def conn
      Faraday.new(url: 'http://api.openweathermap.org/data/2.5') do |route|
        route.params[:appid] = ENV.fetch('WEATHER_API_KEY', nil)
      end
    end
  end
end
