# frozen_string_literal: true

module Sub
  class StripePopupComponent < ViewComponent::Base
    attr_reader :current_user, :delay

    def initialize(current_user: nil, delay: 20_000)
      @current_user = current_user
      @delay = delay
      super
    end
  end
end
