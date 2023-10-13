# frozen_string_literal: true

class RestaurantComponent < ViewComponent::Base
  attr_reader :restaurant

  def initialize(restaurant:, **options)
    @restaurant = restaurant
    @options = options
  end

  private

  def saved
    @options.fetch(:saved, false)
  end
end
