# frozen_string_literal: true

class BusinessFacade
  class << self
    def near(geo: nil, kind: '', budget: nil, dist: 15_000)
      return unless geo.is_a?(Hash) && geo.present?
      return if kind.blank?

      businesses = BusinessService.near(geo:, kind:, budget:, dist:)[:businesses]
      businesses[0..2].map { |bus| BusinessPoro.new(bus) } if businesses
    end
  end
end
