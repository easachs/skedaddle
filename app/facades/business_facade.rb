# frozen_string_literal: true

class BusinessFacade
  class << self
    def near(location = {}, kind = '', budget = nil)
      return unless location.is_a?(Hash) && location.present?
      return if kind.blank?

      businesses = BusinessService.near(location, kind, budget)[:businesses]
      businesses[0..2].map { |bus| BusinessPoro.new(bus) } if businesses
    end
  end
end
