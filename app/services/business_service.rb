# frozen_string_literal: true

class BusinessService
  class << self
    def near(geo, kind = '', budget = nil, dist = 15_000)
      return unless geo.is_a?(Hash) && geo.present? && kind.present?

      Rails.cache.fetch("business/#{kind}/#{budget&.size}/#{dist}/#{geo[:lat]}/#{geo[:lon]}", expires_in: 1.hour) do
        response = fetch_businesses(geo, kind, budget, dist)
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_businesses(geo, kind, budget = nil, dist = 15_000)
      conn.get('search') do |f|
        f.params['latitude']    = geo[:lat]
        f.params['longitude']   = geo[:lon]
        f.params['categories']  = kind
        f.params['price']       = budget if budget.present?
        f.params['radius']      = dist
      end
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |f|
        f.headers['authorization']  = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
        f.params['limit']           = 5
      end
    end
  end
end
