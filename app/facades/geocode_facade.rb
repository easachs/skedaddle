# frozen_string_literal: true

class GeocodeFacade
  class << self
    def geocode(location = {})
      return if location.blank?

      geocode = GeocodeService.geocode(location)
      return if geocode[:data].blank?

      GeocodePoro.new(geocode[:data]&.first).serialized
    end
  end
end
