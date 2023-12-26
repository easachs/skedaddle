# frozen_string_literal: true

class WeatherService
  class << self
    def forecast(location = nil)
      return if location.blank?

      Rails.cache.fetch("weather/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = fetch_weather(location)
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_weather(location)
      conn.get('onecall') do |f|
        f.params['lat']     = location[:lat]
        f.params['lon']     = location[:lon]
        f.params['exclude'] = 'minutely,hourly,alerts'
        f.params['units']   = 'imperial'
      end
    end

    def conn
      Faraday.new(url: 'http://api.openweathermap.org/data/2.5') do |f|
        f.params['appid'] = ENV.fetch('WEATHER_API_KEY', nil)
      end
    end
  end
end
