# frozen_string_literal: true

class ParkFacade
  def self.parks_near(location)
    return if location.blank? || !location.is_a?(Hash)

    parks = ParkService.parks_near(location)
    parks.values[0..2].map { |park| ParkPoro.new(park) } unless parks.value?('invalid_input')
  end
end
