# frozen_string_literal: true

class BusinessService
  def self.businesses_near(location = {}, main = '')
    return unless location.is_a?(Hash) && location.present?
    return if main.blank?

    cache_key = "BusinessService/businesses_near/#{main}/#{location[:lat]}/#{location[:lon]}"
    Rails.cache.fetch(cache_key, expires_in: 7.days) do
      response = fetch_businesses(location, main)
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.fetch_businesses(location, main)
    conn.get('search') do |route|
      route.params['limit'] = 5
      route.params['latitude'] = location[:lat]
      route.params['longitude'] = location[:lon]
      route.params['radius'] = 15_000
      route.params['categories'] = main
    end
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |faraday|
      faraday.headers['authorization'] = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
    end
  end
end
