# frozen_string_literal: true

class BusinessFacade
  class << self
    def near(location = {}, kind = '')
      return unless location.is_a?(Hash) && location.present?
      return if kind.blank?

      businesses = BusinessService.near(location, kind)[:businesses]
      businesses[0..2].map { |bus| BusinessPoro.new(bus) } if businesses
    end
  end
end
