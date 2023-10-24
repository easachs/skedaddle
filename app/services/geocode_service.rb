# frozen_string_literal: true

class GeocodeService
  def self.geocode(location = '')
    return if location.blank?

    cache_key = "GeocodeService/geocode/#{location}"
    Rails.cache.fetch(cache_key, expires_in: 7.days) do
      response = conn.get('/v1/forward') do |route|
        route.params['query'] = location
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.fallback(location)
    return if location.blank?

    cache_key = "GeocodeService/fallback/#{location}"
    Rails.cache.fetch(cache_key, expires_in: 7.days) do
      response = conn2.get('/v1/geo/cities') do |route|
        route.params['namePrefix'] = location
        route.params['minPopulation'] = 50_000
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.conn
    Faraday.new(url: 'http://api.positionstack.com') do |f|
      f.params['access_key'] = ENV.fetch('GEOCODE_API_KEY', nil)
    end
  end

  def self.conn2
    Faraday.new(url: 'https://wft-geo-db.p.rapidapi.com') do |f|
      f.headers['X-RapidAPI-Key'] = ENV.fetch('GEOCODE_FALLBACK_API_KEY', nil)
    end
  end
end
