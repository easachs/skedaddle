# frozen_string_literal: true

class GeocodeFacade
  class << self
    def geocode(location = {})
      return if location.blank?

      geocode = GeocodeService.geocode(location)
      return if geocode&.dig(:results).blank?

      GeocodePoro.new(geocode.dig(:results).first).serialized
    end
  end
end
