# frozen_string_literal: true

module Core
  class ItineraryComponent < ViewComponent::Base
    attr_reader :itinerary, :geocode, :items

    def initialize(itinerary: nil, geocode: nil, items: nil, **options)
      super()
      @itinerary    = itinerary
      @geocode      = geocode
      @items        = items || itinerary&.items
      @options      = options
    end

    def saved       = @options.fetch(:saved, false)
    def tab         = @options.fetch(:tab, 'info')

    def search      = @geocode&.dig(:search) || itinerary&.search
    def city        = @geocode&.dig(:city) || itinerary&.city

    def weather     = WeatherFacade.forecast(coordinates)
    def airports    = items&.dig(:airports)
    def hospitals   = items&.dig(:hospitals)
    def parks       = items&.dig(:parks)
    def activities  = items&.dig(:activities)
    def restaurants = items&.dig(:restaurants)

    def content_button
      tab == 'gpt' ? 'tab-btn' : 'tab-btn active'
    end

    def summary_button
      tab == 'gpt' ? 'tab-btn active' : 'tab-btn'
    end

    def content_class
      tab == 'gpt' ? 'hidden' : 'mt-4 sm:mt-0'
    end

    def summary_class
      tab == 'gpt' ? 'mt-4 sm:mt-0' : 'hidden'
    end

    private

    def coordinates = itinerary&.coordinates || @geocode
  end
end
