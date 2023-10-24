# frozen_string_literal: true

class ParkFacade
  def self.parks_near(location = {})
    return unless location.is_a?(Hash) && location.present?

    parks = ParkService.parks_near(location)
    parks.values[0..2].map { |park| ParkPoro.new(park) } if parks.present?
  end
end
