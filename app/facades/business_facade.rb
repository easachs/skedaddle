# frozen_string_literal: true

class BusinessFacade
  def self.businesses_near(location = {}, main = '')
    return unless location.is_a?(Hash) && location.present?
    return if main.blank?

    businesses = BusinessService.businesses_near(location, main)[:businesses]
    businesses[0..2].map { |bus| BusinessPoro.new(bus) } if businesses
  end
end
