# frozen_string_literal: true

class BusinessService
  class << self
    def near(geocode: nil, kind: '', options: {})
      return unless geocode.is_a?(Hash) && geocode.present? && kind.present?

      cache_path = "business/#{kind}/#{geocode[:lat]}/#{geocode[:lon]}/#{options.values.join}"

      Rails.cache.fetch(cache_path, expires_in: 1.hour) do
        response = fetch_businesses(geocode:, kind:, options:).body
        JSON.parse(response, symbolize_names: true)
      end
    end

    private

    def fetch_businesses(geocode: {}, kind: '', options: {})
      conn.get('search') do |route|
        route.params.merge!(
          latitude: geocode[:lat],
          longitude: geocode[:lon],
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
