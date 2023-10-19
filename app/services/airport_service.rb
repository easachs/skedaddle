# frozen_string_literal: true

class AirportService
  def self.airports_near(location)
    return unless location.is_a?(Hash) && location.present?

    response = conn.get("/flex/airports/rest/v1/json/withinRadius/#{location[:lon]}/#{location[:lat]}/50") do |route|
      route.params['appId'] = ENV.fetch('FLIGHTSTATS_APP_ID', nil)
      route.params['appKey'] = ENV.fetch('FLIGHTSTATS_APP_KEY', nil)
    end
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: 'https://api.flightstats.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
