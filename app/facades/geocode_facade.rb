# frozen_string_literal: true

class GeocodeFacade
  def self.geocode(location)
    geocode = GeocodeService.geocode(location)
    if geocode[:error] || geocode[:data]&.empty?
      { lat: nil, lon: nil }
    else
      { lat: geocode[:data].first[:latitude], lon: geocode[:data].first[:longitude] }
    end
  end
end
