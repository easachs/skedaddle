# frozen_string_literal: true

class BusinessService
  def self.businesses_near(location)
    return unless location.is_a?(Hash) && location.present?

    response = fetch_businesses(location)
    parse_json(response)
  end

  def self.fetch_businesses(location)
    conn.get('search') do |route|
      route.params['limit'] = '5'
      route.params['latitude'] = location[:lat]
      route.params['longitude'] = location[:lon]
      route.params['sort_by'] = 'rating'
      route.params['category'] = 'food'
    end
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |faraday|
      faraday.headers['authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
