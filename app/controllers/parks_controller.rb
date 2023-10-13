# frozen_string_literal: true

class ParksController < ApplicationController
  before_action :find_park, only: %i[destroy]

  def destroy
    itinerary = find_park.itinerary
    find_park.destroy!
    redirect_to itinerary_path(itinerary.id)
  end

  private

  def find_park
    Park.find(params[:id])
  end
end
