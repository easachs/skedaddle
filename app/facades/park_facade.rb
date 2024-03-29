# frozen_string_literal: true

class ParkFacade
  def initialize(key = nil)
    @key = key
  end

  def near(location = {})
    return unless @key.present? && location.is_a?(Hash) && location.present?

    parks = ParkService.new(@key).near(location)
    parks.values[0..2].map { |park| ParkPoro.new(park) } if parks.present?
  end
end
