# frozen_string_literal: true

class ItineraryService
  class << self
    # prepare
    def prepare_items(geocode, session)
      return unless geocode

      { airports: PlaceFacade.near(geocode, 'airport', 50_000),
        hospitals: PlaceFacade.near(geocode, 'hospital', 5_000),
        parks: ParkFacade.near(geocode),
        activities: prepare_businesses(:activities, geocode, session),
        restaurants: prepare_businesses(:restaurants, geocode, session) }
    end

    def prepare_businesses(group, geocode, session)
      return if group.blank? || session[group].blank?

      options = session[:options].transform_keys(&:to_sym)
      session[group].transform_values do |kind|
        options[:budget] = nil if group == :activities
        BusinessFacade.near(geocode:, kind:, options:)
      end
    end

    # new
    def no_results?(items)
      no_activities = no_results_for?(items[:activities])
      no_restaurants = no_results_for?(items[:restaurants])

      (no_activities && no_restaurants) ||
        (items[:activities].blank? && no_restaurants) ||
        (items[:restaurants].blank? && no_activities)
    end

    # other
    def format_date(date)
      Date.parse(date).strftime('%m/%d/%y') if date.present?
    end

    private

    def no_results_for?(group) = group&.all? { |_k, v| v.empty? }
  end
end
