# frozen_string_literal: true

module Sub
  class PlaceComponent < ViewComponent::Base
    attr_reader :place

    def initialize(place:)
      super
      @place = place
    end
  end
end
