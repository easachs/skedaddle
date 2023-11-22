# frozen_string_literal: true

class BusinessService
  class << self
    def near(location = {}, main = '')
      return unless location.is_a?(Hash) && location.present? && main.present?

      Rails.cache.fetch("BusinessService/#{main}/near/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = fetch_businesses(location, main)
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_businesses(location, main)
      conn.get('search') do |route|
        route.params['limit'] = 5
        route.params['latitude'] = location[:lat]
        route.params['longitude'] = location[:lon]
        route.params['radius'] = 15_000
        route.params['categories'] = main
      end
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |faraday|
        faraday.headers['authorization'] = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
      end
    end
  end
end
