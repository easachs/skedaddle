# frozen_string_literal: true

class AirportService
  def self.airports_near(location)
    return if location.blank?

    response = conn.get("/flex/airports/rest/v1/json/withinRadius/#{location[:lon]}/#{location[:lat]}/50") do |route|
      route.params['appId'] = ENV['FLIGHTSTATS_APP_ID']
      route.params['appKey'] = ENV['FLIGHTSTATS_APP_KEY']
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
