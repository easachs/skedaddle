# frozen_string_literal: true

module Core
  class DashboardComponent < ViewComponent::Base
    def initialize(signed_in: false)
      super
      @signed_in = signed_in
    end
  end
end
