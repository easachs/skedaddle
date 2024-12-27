# frozen_string_literal: true

class BusinessesController < ApplicationController
  before_action :business, only: %i[destroy favorite]

  def destroy
    itinerary = business.itinerary
    business.destroy!
    redirect_to itinerary_path(itinerary)
  end

  def favorite
    business.update!(favorited: !business.favorited)
    render turbo_stream: turbo_stream.replace("favorite-#{business.name.parameterize}",
                                              partial: 'shared/favorite', locals: { business: })
  end

  private

  def business
    @business ||= Business.find(params[:id])
  end
end
