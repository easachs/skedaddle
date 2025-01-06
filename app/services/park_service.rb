# frozen_string_literal: true

class ParkService
  class << self
    def near(location = {})
      return unless location.is_a?(Hash) && location.present?

      Rails.cache.fetch("park/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = fetch_parks(location).body
        response.match?(/!DOCTYPE|Invalid/) ? nil : JSON.parse(response, symbolize_names: true)
      end
    end

    private

    def fetch_parks(location)
      conn.get('/activity/') do |route|
        route.params.merge!(limit: 5, lat: location[:lat], lon: location[:lon], radius: 100)
      end
    end

    def conn
      Faraday.new(url: 'https://trailapi-trailapi.p.rapidapi.com') do |route|
        route.headers['X-RapidAPI-Key'] = ENV.fetch('RAPID_API_KEY', nil)
      end
    end
  end
end
