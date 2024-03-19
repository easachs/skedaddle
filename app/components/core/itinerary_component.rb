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
    def tab         = @options.fetch(:tab, 'info')

    def search      = @geocode&.dig(:search) || itinerary&.search
    def city        = @geocode&.dig(:city) || itinerary&.city

    def weather     = WeatherFacade.forecast(coordinates)
    def airports    = items&.dig(:airports)
    def hospitals   = items&.dig(:hospitals)
    def parks       = items&.dig(:parks)
    def activities  = items&.dig(:activities)
    def restaurants = items&.dig(:restaurants)

    # tab classes
    def gpt_tab     = tab == 'gpt'
    def info_btn    = gpt_tab ? '' : 'active'
    def gpt_btn     = gpt_tab ? 'active' : ''
    def info_class  = gpt_tab ? 'hidden' : 'mt-4 sm:mt-0'
    def gpt_class   = gpt_tab ? 'mt-4 sm:mt-0' : 'hidden'

    def coordinates = itinerary&.coordinates || @geocode
  end
end
