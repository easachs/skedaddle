# frozen_string_literal: true

class BusinessFacade
  def self.businesses_near(city)
    businesses = BusinessService.businesses_near(city)
    if businesses[:businesses]
      businesses[:businesses][0..2].map do |business|
        BusinessPoro.new(business)
      end
    else
      []
    end
  end
end
