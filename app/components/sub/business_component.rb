# frozen_string_literal: true

module Sub
  class BusinessComponent < ViewComponent::Base
    attr_reader :business, :saved

    def initialize(business:, saved: false)
      super
      @business = business
      @saved    = saved
    end
  end
end
