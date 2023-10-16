# frozen_string_literal: true

class GeocodeFacade
  def self.geocode(location)
    geocode = GeocodeService.geocode(location)
    if geocode[:error] || geocode[:data]&.empty?
      { lat: nil, lon: nil }
    else
      GeocodePoro.new(geocode[:data].first).serialized
    end
  end
end
