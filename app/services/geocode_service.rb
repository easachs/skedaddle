# frozen_string_literal: true

class GeocodeService
  def self.geocode(location)
    response = conn.get('/v1/forward') do |route|
      route.params['query'] = location
      route.params['access_key'] = ENV['GEOCODE_API_KEY']
    end
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: 'http://api.positionstack.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
