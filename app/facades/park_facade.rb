# frozen_string_literal: true

class ParkFacade
  def initialize(key = nil)
    @key = key
  end

  def near(location = {})
    return unless @key.present? && location.is_a?(Hash)

    parks = ParkService.new(@key).near(location)
    parks.values[0..2].map { |park| ParkPoro.new(park) } unless parks&.key?(:message) || parks.blank?
  end
end
