# frozen_string_literal: true

class ItinerariesController < ApplicationController
  before_action :geocode, :find_items, only: %i[new create]
  before_action :not_logged_in

  def index
    @itineraries = current_user.itineraries.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @itinerary = find_itinerary
    redirect_to itineraries_path if @itinerary.user_id != current_user.id
  rescue StandardError
    redirect_to itineraries_path
  end

  def new
    return unless params[:search].blank? || [@parks, @businesses].all?(&:blank?)

    redirect_to root_path
    flash[:error] = t('flash.errors.no_results')
  end

  def create
    itinerary = current_user.itineraries.create!(@geocode)
    return unless itinerary.save

    create_items(itinerary)
    redirect_to itinerary_path(itinerary)
  end

  def destroy
    find_itinerary.destroy!
    redirect_to itineraries_path
  end

  private

  def find_itinerary
    Itinerary.find(params[:id])
  end

  def geocode
    @geocode = GeocodeFacade.geocode(params[:search].delete("'"))
    @geocode&.merge!(search: params[:search]) if @geocode&.dig(:search).blank?
  end

  def find_items
    return unless @geocode

    @airports = AirportFacade.airports_near(@geocode)
    @parks = ParkFacade.parks_near(@geocode)
    @businesses = BusinessFacade.businesses_near(@geocode)
  end

  def create_items(itinerary)
    @airports&.each { |airport| itinerary.airports.create!(airport.serialized) }
    @parks&.each { |park| itinerary.parks.create!(park.serialized) }
    @businesses&.each { |business| itinerary.businesses.create!(business.serialized) }
  end
end
