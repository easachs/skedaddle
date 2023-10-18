# frozen_string_literal: true

class BusinessFacade
  def self.businesses_near(location)
    businesses = BusinessService.businesses_near(location)[:businesses]
    businesses[0..2].map { |bus| BusinessPoro.new(bus) } if businesses
  end
end
