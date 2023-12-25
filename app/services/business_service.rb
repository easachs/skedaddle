# frozen_string_literal: true

class BusinessService
  class << self
    def near(location = {}, kind = '', budget = nil)
      return unless location.is_a?(Hash) && location.present? && kind.present?

      Rails.cache.fetch("business/#{budget&.size}/#{kind}/#{location[:lat]}/#{location[:lon]}", expires_in: 1.hour) do
        response = fetch_businesses(location, kind, budget)
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_businesses(location, kind, budget = nil)
      conn.get('search') do |route|
        route.params['latitude']    = location[:lat]
        route.params['longitude']   = location[:lon]
        route.params['categories']  = kind
        route.params['price']       = budget if budget.present?
      end
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |faraday|
        faraday.headers['authorization']  = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
        faraday.params['limit']           = 5
        faraday.params['radius']          = 15_000
      end
    end
  end
end
