# frozen_string_literal: true

class BusinessService
  class << self
    def near(geo: nil, kind: '', options: {})
      return unless geo.is_a?(Hash) && geo.present? && kind.present?

      Rails.cache.fetch("business/#{kind}/#{geo[:lat]}/#{geo[:lon]}/#{options.values.join}", expires_in: 1.hour) do
        response = fetch_businesses(geo:, kind:, options:)
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_businesses(geo: {}, kind: '', options: {})
      conn.get('search') do |f|
        set_location_params(f, geo)
        set_business_params(f, kind, options)
      end
    end

    def set_location_params(route, geo)
      route.params['latitude']  = geo[:lat]
      route.params['longitude'] = geo[:lon]
    end

    def set_business_params(route, kind, options)
      route.params['categories'] = kind
      route.params['price']      = options[:budget] if options[:budget]
      route.params['radius']     = options[:distance].to_i * 1_000
      route.params['sort_by']    = options[:sort] if options[:sort]
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |f|
        f.headers['authorization']  = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
        f.params['limit']           = 5
      end
    end
  end
end
