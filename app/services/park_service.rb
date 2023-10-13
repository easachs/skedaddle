# frozen_string_literal: true

class ParkService
  def self.parks_near(location)
    geocode = GeocodeFacade.geocode(location)
    response = conn.get('/activity/') do |route|
      route.params['limit'] = '5'
      route.params['lat'] = geocode[:lat]
      route.params['lon'] = geocode[:lon]
      route.params['radius'] = '100'
    end
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: 'https://trailapi-trailapi.p.rapidapi.com') do |faraday|
      faraday.headers['X-RapidAPI-Key'] = ENV.fetch('TRAIL_API_KEY', nil)
    end
  end

  def self.parse_json(response)
    response.body.include?('!DOCTYPE') ? { code: 'invalid_input' } : JSON.parse(response.body, symbolize_names: true)
  end
end
