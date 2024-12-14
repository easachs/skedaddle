# frozen_string_literal: true

class BusinessService
  class << self
    def near(geo: nil, kind: '', options: {})
      return unless geo.is_a?(Hash) && geo.present? && kind.present?

      Rails.cache.fetch("business/#{kind}/#{geo[:lat]}/#{geo[:lon]}/#{options.values.join}", expires_in: 1.hour) do
        response = fetch_businesses(geo:, kind:, options:).body
        JSON.parse(response, symbolize_names: true)
      end
    end

    private

    def fetch_businesses(geo: {}, kind: '', options: {})
      conn.get('search') do |route|
        route.params.merge!(
          latitude: geo[:lat],
          longitude: geo[:lon],
          categories: kind,
          radius: (options[:distance] || 15).to_i * 1_000,
          sort_by: options[:sort] || 'best_match'
        )

        route.params[:price] = options[:budget] if options[:budget]
      end
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |route|
        route.headers[:authorization] = "Bearer #{ENV.fetch('YELP_API_KEY', nil)}"
        route.params[:limit]          = 5
      end
    end
  end
end
