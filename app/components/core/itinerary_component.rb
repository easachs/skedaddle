# frozen_string_literal: true

module Core
  class ItineraryComponent < ViewComponent::Base
    attr_reader :itinerary, :geocode, :items, :saved

    def initialize(itinerary: nil, geocode: nil, items: nil, saved: false)
      super()
      @itinerary = itinerary
      @geocode = geocode
      @items = items || itinerary&.items
      @saved = saved
    end

    def search = @geocode&.dig(:search) || itinerary&.search
    def city = @geocode&.dig(:city) || itinerary&.city

    def weather = WeatherFacade.forecast(coordinates)
    def airports = items&.dig(:airports)
    def hospitals = items&.dig(:hospitals)
    def parks = items&.dig(:parks)
    def activities = items&.dig(:activities)
    def restaurants = items&.dig(:restaurants)

    def title_class = 'font-bold text-xl'

    private

    def coordinates = itinerary&.coordinates || @geocode
  end
end
