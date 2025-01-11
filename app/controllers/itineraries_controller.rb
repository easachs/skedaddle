# frozen_string_literal: true

class ItinerariesController < ApplicationController
  before_action :authenticate_user!, except: %i[prepare new]
  before_action :prepare_geocode, :prepare_items, only: %i[new create]
  before_action :find_itinerary, only: %i[show update destroy]

  def index
    @itineraries = current_user.itineraries
                               .order(updated_at: :desc)
                               .page(params[:page])
                               .per(12)
  end

  def show
    redirect_with_message(message: 'no_access', path: itineraries_path) if @itinerary.user != current_user
  rescue StandardError
    redirect_with_message(message: 'not_found', path: itineraries_path)
  end

  def prepare
    initialize_session
    redirect_to new_itinerary_path
  end

  def new
    return redirect_with_message(message: 'no_results') if [@items].all?(&:blank?) ||
                                                           ItineraryService.no_results?(@items)

    redirect_with_message(message: 'too_broad') if @geocode&.dig(:city).blank?
  end

  def create
    if current_user&.credit_left?
      current_user.spend_credit!
      itinerary = Itinerary.create_for_user!(current_user, @geocode, @items)
      clear_session
      redirect_to itinerary_path(itinerary)
    else
      redirect_with_message(message: 'no_credit', path: new_itinerary_path(prompt: true))
    end
  end

  def update
    if current_user.credit_left?
      @itinerary.fresh_plan!
      redirect_to itinerary_path(@itinerary, tab: 'plan')
    else
      redirect_with_message(message: 'no_credit', path: itinerary_path(@itinerary))
    end
  end

  def destroy
    @itinerary.destroy!
    redirect_to itineraries_path
  end

  private

  def initialize_session
    %i[search activities restaurants start end].each { |key| session[key] = params[key] }
    session[:options] = params.slice(:budget, :distance, :sort)
  end

  def clear_session
    %i[search activities restaurants start end options].each { |key| session.delete(key) }
  end

  def prepare_geocode
    @geocode = GeocodeFacade.geocode(session[:search]&.delete("'"))
                            &.merge!(start_date: ItineraryService.format_date(session[:start]),
                                     end_date: ItineraryService.format_date(session[:end]))
  end

  def prepare_items
    @items = ItineraryService.prepare_items(@geocode, session)
  end

  def find_itinerary
    @itinerary = Itinerary.find_by(id: params[:id])
  end
end
