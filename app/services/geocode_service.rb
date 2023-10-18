# frozen_string_literal: true

class GeocodeService
  def self.geocode(location)
    response = conn.get('/v1/forward') do |route|
      route.params['query'] = location
      route.params['access_key'] = ENV['GEOCODE_API_KEY']
    end
    parse_json(response)
  end

  def self.fallback(location)
    response = conn2.get('/v1/geo/cities') do |route|
      route.params['namePrefix'] = location
      route.params['minPopulation'] = 50_000
      route.headers['X-RapidAPI-Key'] = ENV['GEOCODE_FALLBACK_API_KEY']
    end
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: 'http://api.positionstack.com')
  end

  def self.conn2
    Faraday.new(url: 'https://wft-geo-db.p.rapidapi.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
