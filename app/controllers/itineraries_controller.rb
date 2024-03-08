# frozen_string_literal: true

class ItinerariesController < ApplicationController
  include Redirection

  before_action :authenticate_user!, except: %i[prepare new]
  before_action :geocode, :find_items, only: %i[new create]

  def index
    @itineraries = current_user.itineraries
                               .order(updated_at: :desc)
                               .page(params[:page])
                               .per(5)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    redirect_with_message(message: 'no_access', path: itineraries_path) if @itinerary.user != current_user
  rescue StandardError
    redirect_with_message(message: 'not_found', path: itineraries_path)
  end

  def prepare
    initialize_session
    redirect_to new_itinerary_path
  end

  def new
    return redirect_with_message(message: 'no_results') if [@items].all?(&:blank?)

    redirect_with_message(message: 'too_broad') if @geocode&.dig(:city).blank?
  end

  def create
    itinerary = current_user.itineraries.create!(@geocode)
    ItineraryService.populate(itinerary, @items) if itinerary.persisted?
    clear_session
    redirect_to itinerary_path(itinerary)
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    if gpt_response.present? && summary_eligible?
      fresh_summary
      redirect_to itinerary_path(@itinerary, tab: 'gpt')
    else
      redirect_with_message(message: 'openai_key', path: itinerary_path(@itinerary))
    end
  end

  def destroy
    Itinerary.find(params[:id]).destroy!
    redirect_to itineraries_path
  end

  private

  def initialize_session
    %i[search activities restaurants start end].each { |key| session[key] = params[key] }
    session[:options] = params.slice(:budget, :distance, :sort)
  end

  def clear_session
    %i[search activities restaurants start end options]
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
                             &.merge!(parks: ParkFacade.new(current_user&.trailapi_key).near(@geocode),
                                      activities: find_businesses(:activities),
                                      restaurants: find_businesses(:restaurants))
  end

  def find_businesses(group)
    return if group.blank? || session[group].blank?

    options = session[:options].transform_keys(&:to_sym)
    session[group].transform_values do |kind|
      options[:budget] = nil if group == :activities
      BusinessFacade.near(geo: @geocode, kind:, options:)
    end
  end

  def summary_eligible?
    current_user&.credit&.positive? || current_user&.openai_key.present?
  end

  def fresh_summary
    if current_user&.credit&.positive? && current_user&.openai_key.blank?
      current_user.credit -= 1
      current_user.save
    end
    @itinerary.summary&.destroy
    @itinerary.create_summary!(response: @gpt_response)
  end

  def gpt_response
    key = current_user&.credit&.positive? ? ENV.fetch('OPENAI_API_KEY', nil) : current_user&.openai_key
    @gpt_response ||= GptService.new(key).summary(@itinerary.decorate)
  end
end
