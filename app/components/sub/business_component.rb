# frozen_string_literal: true

module Sub
  class BusinessComponent < ViewComponent::Base
    def initialize(business:, saved: false)
      super
      @business = business
      @saved = saved
    end
  end
end
