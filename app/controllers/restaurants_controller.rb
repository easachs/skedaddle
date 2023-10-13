# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[destroy]

  def destroy
    itinerary = find_restaurant.itinerary
    find_restaurant.destroy!
    redirect_to itinerary_path(itinerary.id)
  end

  private

  def find_restaurant
    Restaurant.find(params[:id])
  end
end
