# frozen_string_literal: true

class BusinessFacade
  class << self
    def near(geo: {}, kind: '', options: {})
      return unless geo.is_a?(Hash) && geo.present?
      return if kind.blank?

      businesses = BusinessService.near(geo:, kind:, options:)[:businesses]
      count = options[:count].to_i - 1
      businesses[0..count].map { |bus| BusinessPoro.new(bus) } if businesses
    end
  end
end
