# frozen_string_literal: true

module Core
  class ItineraryComponent < ViewComponent::Base
    def initialize(search:, city:, items:, **options)
      super
      @search = search
      @city = city
      @items = items
      @options = options
    end

    private

    def id = @options.fetch(:id, nil)
    def saved = @options.fetch(:saved, false)

    def airports = @items[:airports]
    def hospitals = @items[:hospitals]
    def parks = @items[:parks]
    def activities = @items[:activities]
    def restaurants = @items[:restaurants]
  end
end
