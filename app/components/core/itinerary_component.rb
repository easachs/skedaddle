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

    def airports = @items&.dig(:airports)
    def hospitals = @items&.dig(:hospitals)
    def parks = @items&.dig(:parks)
    def activities = @items&.dig(:activities)
    def restaurants = @items&.dig(:restaurants)
  end
end
