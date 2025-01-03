# frozen_string_literal: true

module Core
  class ItineraryComponent < ViewComponent::Base
    attr_reader :itinerary, :geocode, :items

    def initialize(itinerary: nil, geocode: nil, items: nil, **options)
      super
      @itinerary    = itinerary
      @geocode      = geocode
      @items        = items
      @options      = options
    end

    private

    def user        = @options.fetch(:current_user, nil)
    def saved       = @options.fetch(:saved, false)
    def tab         = @options.fetch(:tab, 'places')

    def search      = @geocode&.dig(:search) || itinerary&.search
    def city        = @geocode&.dig(:city) || itinerary&.city

    def weather     = WeatherFacade.forecast(coordinates)
    def airports    = items&.dig(:airports)
    def hospitals   = items&.dig(:hospitals)
    def parks       = items&.dig(:parks)
    def activities  = items&.dig(:activities)
    def restaurants = items&.dig(:restaurants)

    # tab classes
    def places_tab  = %w[info map plan].exclude?(tab)
    def info_tab    = itinerary&.info.present? && tab == 'info'
    def map_tab     = tab == 'map'
    def plan_tab    = tab == 'plan'

    def coordinates = itinerary&.coordinates || @geocode

    class PlacesTab < ItineraryComponent; end
    class InfoTab < ItineraryComponent; end
    class MapTab < ItineraryComponent; end
    class PlanTab < ItineraryComponent; end
  end
end
