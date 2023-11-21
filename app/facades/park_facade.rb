# frozen_string_literal: true

class ParkFacade
  class << self
    def near(location = {})
      return unless location.is_a?(Hash) && location.present?

      parks = ParkService.near(location)
      parks.values[0..2].map { |park| ParkPoro.new(park) } if parks.present?
    end
  end
end
