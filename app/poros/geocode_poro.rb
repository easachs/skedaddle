# frozen_string_literal: true

class GeocodePoro
  attr_reader :label,
              :city,
              :region,
              :country,
              :lat,
              :lon

  def initialize(attributes)
    @label = attributes[:label]
    @city = attributes[:locality] || attributes[:city]
    @region = attributes[:region]
    @country = attributes[:country]
    @lat = attributes[:latitude]
    @lon = attributes[:longitude]
  end

  def serialized
    {
      label: @label,
      city: @city,
      region: @region,
      country: @country,
      lat: @lat,
      lon: @lon
    }
  end
end
