# frozen_string_literal: true

module Sub
  class ParkComponent < ViewComponent::Base
    attr_reader :park, :saved

    def initialize(park:, saved: false)
      super
      @park = park
      @saved = saved
    end
  end
end
