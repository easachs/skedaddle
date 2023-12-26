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
      conn.get('search') do |f|
        f.params['latitude']    = location[:lat]
        f.params['longitude']   = location[:lon]
        f.params['categories']  = kind
        f.params['price']       = budget if budget.present?
      end
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |f|
        f.headers['authorization']  = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
        f.params['limit']           = 5
        f.params['radius']          = 15_000
      end
    end
  end
end
