# frozen_string_literal: true

class GeocodePoro
  attr_reader :search,
              :city,
              :region,
              :country,
              :lat,
              :lon

  def initialize(attributes)
    @search = attributes&.dig(:label)
    @city = attributes&.dig(:locality) || attributes&.dig(:city)
    @region = attributes&.dig(:region)
    @country = attributes&.dig(:country)
    @lat = attributes&.dig(:latitude)
    @lon = attributes&.dig(:longitude)
  end

  def serialized
    { search:, city:, region:, country:, lat:, lon: }
  end
end
