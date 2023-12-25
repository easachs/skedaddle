# frozen_string_literal: true

class ParkService
  class << self
    def near(location = {})
      return unless location.is_a?(Hash) && location.present?

      Rails.cache.fetch("ParkService/near/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = fetch_parks(location)
        response.body.match?(/!DOCTYPE|Invalid/) ? {} : JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_parks(location)
      conn.get('/activity/') do |route|
        route.params['limit']   = 5
        route.params['lat']     = location[:lat]
        route.params['lon']     = location[:lon]
        route.params['radius']  = 100
      end
    end

    def conn
      Faraday.new(url: 'https://trailapi-trailapi.p.rapidapi.com') do |faraday|
        faraday.headers['X-RapidAPI-Key'] = ENV.fetch('RAPID_API_KEY', nil)
      end
    end
  end
end
