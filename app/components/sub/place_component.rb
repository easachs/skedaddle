# frozen_string_literal: true

module Sub
  class PlaceComponent < ViewComponent::Base
    def initialize(place:)
      super
      @place = place
    end
  end
end
