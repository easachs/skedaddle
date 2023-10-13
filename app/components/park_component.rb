# frozen_string_literal: true

class ParkComponent < ViewComponent::Base
  attr_reader :park

  def initialize(park:, **options)
    @park = park
    @options = options
  end

  private

  def saved
    @options.fetch(:saved, false)
  end
end
