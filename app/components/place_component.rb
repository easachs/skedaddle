# frozen_string_literal: true

class PlaceComponent < ViewComponent::Base
  attr_reader :place

  def initialize(place:)
    super
    @place = place
  end
end
