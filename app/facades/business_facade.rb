# frozen_string_literal: true

class BusinessFacade
  class << self
    def near(location = {}, main = '')
      return unless location.is_a?(Hash) && location.present?
      return if main.blank?

      businesses = BusinessService.near(location, main)[:businesses]
      businesses[0..2].map { |bus| BusinessPoro.new(bus) } if businesses
    end
  end
end
