# frozen_string_literal: true

class ItinerariesController < ApplicationController
  before_action :geocode, :find_parks, :find_businesses, only: %i[new create]
  before_action :not_logged_in

  def index
    @itineraries = current_user.itineraries
  end

  def show
    @itinerary = find_itinerary
    redirect_to itineraries_path if @itinerary.user_id != current_user.id
  rescue StandardError
    redirect_to itineraries_path
  end

  def new
    return unless params[:search].blank? || (@parks.empty? && @businesses.empty?)

    redirect_to root_path
    flash[:error] = 'No results found.'
  end

  def create
    itinerary = current_user.itineraries.create!(@geocode)
    return unless itinerary.save

    @parks.each { |park| itinerary.parks.create!(park.serialized) }
    @businesses.each { |business| itinerary.businesses.create!(business.serialized) }
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
  end

  def find_parks
    @parks = ParkFacade.parks_near(@geocode)
  end

  def find_businesses
    @businesses = BusinessFacade.businesses_near(@geocode)
  end
end
