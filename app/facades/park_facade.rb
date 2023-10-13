# frozen_string_literal: true

class ParkFacade
  def self.parks_near(location)
    parks = ParkService.parks_near(location)
    !parks.value?('invalid_input') ? parks.values[0..2].map { |park| ParkPoro.new(park) } : []
  end
end
