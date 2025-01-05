# frozen_string_literal: true

class BusinessFacade
  class << self
    def near(geocode: {}, kind: '', options: {})
      return unless geocode.is_a?(Hash) && geocode.present?
      return if kind.blank?

      businesses = BusinessService.near(geocode:, kind:, options:)[:businesses]
      businesses[0..3].map { |bus| BusinessPoro.new(bus) } if businesses
    end
  end
end
