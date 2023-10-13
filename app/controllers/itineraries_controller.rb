# frozen_string_literal: true

class ItinerariesController < ApplicationController
  before_action :search, :find_parks, :find_restaurants, only: %i[new create]
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
    return unless params[:search].blank? || (@found_parks.empty? && @found_restaurants.empty?)

    redirect_to dashboard_path
    flash[:error] = 'No results found.'
  end

  def create
    itinerary = current_user.itineraries.new(itinerary_params)
    return unless itinerary.save

    @found_parks.each { |park| itinerary.parks.create!(park.serialized) }
    @found_restaurants.each { |restaurant| itinerary.restaurants.create!(restaurant.serialized) }
    flash[:success] = 'New itinerary saved.'
    redirect_to itinerary_path(itinerary.id)
  end

  def destroy
    find_itinerary.destroy!
    redirect_to itineraries_path
  end

  private

  def itinerary_params
    params.permit(:search)
  end

  def find_itinerary
    Itinerary.find(params[:id])
  end

  def search
    @search = itinerary_params[:search].upcase.delete("'")
  end

  def find_parks
    @found_parks = ParkFacade.parks_near(@search)
  end

  def find_restaurants
    @found_restaurants = RestaurantFacade.restaurants_near(@search)
  end
end
