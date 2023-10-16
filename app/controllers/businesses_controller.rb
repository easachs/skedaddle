# frozen_string_literal: true

class BusinessesController < ApplicationController
  before_action :find_business, only: %i[destroy]

  def destroy
    itinerary = find_business.itinerary
    find_business.destroy!
    redirect_to itinerary_path(itinerary.id)
  end

  private

  def find_business
    Business.find(params[:id])
  end
end
