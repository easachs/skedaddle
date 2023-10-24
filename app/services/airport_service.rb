# frozen_string_literal: true

class AirportService
  def self.airports_near(location = {})
    return unless location.is_a?(Hash) && location.present?

    cache_key = "AirportService/airports_near/#{location[:lon]}/#{location[:lat]}"
    Rails.cache.fetch(cache_key, expires_in: 7.days) do
      response = conn.get("/flex/airports/rest/v1/json/withinRadius/#{location[:lon]}/#{location[:lat]}/50")
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.conn
    Faraday.new(url: 'https://api.flightstats.com') do |f|
      f.params['appId'] = ENV.fetch('FLIGHTSTATS_APP_ID', nil)
      f.params['appKey'] = ENV.fetch('FLIGHTSTATS_APP_KEY', nil)
    end
  end
end
