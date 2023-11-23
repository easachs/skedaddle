# frozen_string_literal: true

module Core
  class DashboardComponent < ViewComponent::Base
    def initialize(logged_in: false)
      super
      @logged_in = logged_in
    end
  end
end
