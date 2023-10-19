# frozen_string_literal: true

class GeocodePoro
  attr_reader :search,
              :city,
              :region,
              :country,
              :lat,
              :lon

  def initialize(attributes)
    @search = attributes[:label]
    @city = attributes[:locality] || attributes[:city]
    @region = attributes[:region]
    @country = attributes[:country]
    @lat = attributes[:latitude]
    @lon = attributes[:longitude]
  end

  def serialized
    {
      search: @search,
      city: @city,
      region: @region,
      country: @country,
      lat: @lat,
      lon: @lon
    }
  end
end
