# frozen_string_literal: true

class GeocodePoro
  attr_reader :label,
              :locality,
              :region,
              :country,
              :lat,
              :lon

  def initialize(attributes)
    @label = attributes[:label]
    @locality = attributes[:locality]
    @region = attributes[:region]
    @country = attributes[:country]
    @lat = attributes[:latitude]
    @lon = attributes[:longitude]
  end

  def serialized
    {
      label: @label,
      locality: @locality,
      region: @region,
      country: @country,
      lat: @lat,
      lon: @lon
    }
  end
end
