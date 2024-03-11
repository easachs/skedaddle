# frozen_string_literal: true

module Core
  class DashboardComponent < ViewComponent::Base
    attr_reader :current_user

    def initialize(current_user: nil)
      super
      @current_user = current_user
    end
  end
end
