# frozen_string_literal: true

class ParkFacade
  class << self
    def near(location = {})
      return unless location.is_a?(Hash)

      parks = ParkService.near(location)
      parks.values[0..2].map { |park| ParkPoro.new(park) } unless parks&.key?(:message) || parks.blank?
    end
  end
end
