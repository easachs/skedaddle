# frozen_string_literal: true

class AirportComponent < ViewComponent::Base
  attr_reader :airport

  def initialize(airport:)
    super
    @airport = airport
  end
end
