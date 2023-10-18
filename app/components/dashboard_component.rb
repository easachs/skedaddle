# frozen_string_literal: true

class DashboardComponent < ViewComponent::Base
  attr_reader :logged_in

  def initialize(logged_in: false)
    super
    @logged_in = logged_in
  end
end
