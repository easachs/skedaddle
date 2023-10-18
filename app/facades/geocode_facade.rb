# frozen_string_literal: true

class GeocodeFacade
  def self.geocode(location)
    geocode = GeocodeService.geocode(location)
    if geocode[:error] || geocode[:data]&.empty?
      fallback(location)
    else
      GeocodePoro.new(geocode[:data].first).serialized
    end
  end

  def self.fallback(location)
    geocode = GeocodeService.fallback(location)
    return if geocode[:error] || geocode[:data]&.empty?

    GeocodePoro.new(geocode[:data].first).serialized
  end
end
