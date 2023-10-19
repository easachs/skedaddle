# frozen_string_literal: true

class GeocodeFacade
  def self.geocode(location)
    return if location.blank?

    geocode = GeocodeService.geocode(location)
    if geocode[:data].blank?
      fallback(location)
    else
      GeocodePoro.new(geocode[:data]&.first).serialized
    end
  end

  def self.fallback(location)
    geocode = GeocodeService.fallback(location)
    return if geocode[:data].blank?

    GeocodePoro.new(geocode[:data]&.first).serialized
  end
end
