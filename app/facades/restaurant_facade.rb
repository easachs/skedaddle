# frozen_string_literal: true

class RestaurantFacade
  def self.restaurants_near(city)
    restaurants = RestaurantService.restaurants_near(city)
    if restaurants[:businesses]
      restaurants[:businesses][0..2].map do |restaurant|
        RestaurantPoro.new(restaurant)
      end
    else
      []
    end
  end
end
