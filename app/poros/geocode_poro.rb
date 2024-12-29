# frozen_string_literal: true

class GeocodePoro
  attr_reader :search, :city, :region, :country, :lat, :lon

  def initialize(attributes)
    @components = attributes&.dig(:address_components)
    @search     = attributes&.dig(:formatted_address)
    @city       = extract_component('locality')
    @region     = extract_component('administrative_area_level_1')
    @country    = extract_component('country')
    @lat        = attributes&.dig(:geometry, :location, :lat)
    @lon        = attributes&.dig(:geometry, :location, :lng)
  end

  def extract_component(type)
    component = @components&.find { |comp| comp[:types].include?(type) }
    component&.dig(:long_name)
  end

  def serialized
    { search:, city:, region:, country:, lat:, lon: }
  end
end
