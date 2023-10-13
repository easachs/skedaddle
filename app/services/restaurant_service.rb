# frozen_string_literal: true

class RestaurantService
  def self.restaurants_near(location)
    geocode = GeocodeFacade.geocode(location)
    response = conn.get('search') do |route|
      route.params['limit'] = '5'
      route.params['latitude'] = geocode[:lat]
      route.params['longitude'] = geocode[:lon]
      route.params['sort_by'] = 'rating'
      route.params['category'] = 'food'
    end
    parse_json(response)
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
