# frozen_string_literal: true

class ParkService
  def self.parks_near(location = {})
    return unless location.is_a?(Hash) && location.present?

    cache_key = "ParkService/parks_near/#{location[:lat]}/#{location[:lon]}"
    Rails.cache.fetch(cache_key, expires_in: 7.days) do
      response = fetch_parks(location)
      response.body.include?('!DOCTYPE') ? {} : JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.fetch_parks(location)
    conn.get('/activity/') do |route|
      route.params['limit'] = 5
      route.params['lat'] = location[:lat]
      route.params['lon'] = location[:lon]
      route.params['radius'] = 100
    end
  end

  def self.conn
    Faraday.new(url: 'https://trailapi-trailapi.p.rapidapi.com') do |faraday|
      faraday.headers['X-RapidAPI-Key'] = ENV.fetch('TRAIL_API_KEY', nil)
    end
  end
end
