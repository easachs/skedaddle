# frozen_string_literal: true

class ItinerariesController < ApplicationController
  include Redirection

  before_action :authenticate_user!
  before_action :geocode, :find_items, only: %i[new create]

  def index
    @itineraries = current_user.itineraries
                               .order(created_at: :desc)
                               .page(params[:page])
                               .per(5)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    redirect_with_error(message: 'no_access', path: itineraries_path) if @itinerary.user != current_user
  rescue StandardError
    redirect_with_error(message: 'not_found', path: itineraries_path)
  end

  def prepare
    initialize_session
    redirect_to new_itinerary_path
  end

  def new
    return redirect_with_error(message: 'no_results') if [@items]&.all?(&:blank?)

    redirect_with_error(message: 'too_broad') if @geocode&.dig(:city).blank?
  end

  def create
    itinerary = current_user.itineraries.create!(@geocode)
    ItineraryService.populate(itinerary, @items) if itinerary.persisted?
    clear_session
    redirect_to itinerary_path(itinerary)
  end

  def update
    itinerary = Itinerary.find(params[:id])
    response = GptService.summary(itinerary)
    itinerary.create_summary!(response:)
    redirect_to itinerary_path(itinerary)
  end

  def destroy
    Itinerary.find(params[:id]).destroy!
    redirect_to itineraries_path
  end

  private

  def initialize_session
    %i[search activities restaurants budget start end]
      .each { |key| session[key] = params[key] }
  end

  def clear_session
    %i[search activities restaurants budget start end]
      .each { |key| session.delete(key) }
  end

  def geocode
    @geocode = GeocodeFacade.geocode(session[:search]&.delete("'"))
                            &.merge!(start_date: format_date(session[:start]),
                                     end_date: format_date(session[:end]))
  end

  def format_date(date)
    Date.parse(date).strftime('%m/%d/%y') if date.present?
  end

  def find_items
    @items = ItineraryService.find_items(@geocode)
                             &.merge!(activities: find_businesses(:activities),
                                      restaurants: find_businesses(:restaurants))
  end

  def find_businesses(group)
    return if group.blank? || session[group].blank?

    session[group].transform_values { |cat| BusinessFacade.near(@geocode, cat, session[:budget]) }
  end
end
