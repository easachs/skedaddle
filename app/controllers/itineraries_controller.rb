# frozen_string_literal: true

class ItinerariesController < ApplicationController
  before_action :geocode, :find_items, only: %i[new create]
  before_action :not_logged_in

  def index
    @itineraries = current_user.itineraries
                               .order(created_at: :desc)
                               .page(params[:page])
                               .per(5)
  end

  def show
    @itinerary = find_itinerary
    redirect_to itineraries_path if @itinerary.user_id != current_user.id
  rescue StandardError
    redirect_to itineraries_path
  end

  def new
    initialize_session
    return unless params[:search].blank? || [@items].all?(&:blank?)

    redirect_to root_path
    flash[:error] = t('flash.errors.no_results')
  end

  def create
    itinerary = current_user.itineraries.create!(@geocode)
    populate_itinerary(itinerary) if itinerary.persisted?
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

    @items = {
      airports: PlaceFacade.near(@geocode, 'airport', 5000),
      hospitals: PlaceFacade.near_new(@geocode, 'hospital'),
      parks: ParkFacade.near(@geocode),
      activities: find_businesses(:activities),
      restaurants: find_businesses(:restaurants)
    }
  end

  def find_businesses(group)
    return if group.blank? || params[group].blank?

    params[group].transform_values do |category|
      BusinessFacade.near(@geocode, category)
    end
  end

  def initialize_session
    session[:activities] = params[:activities]
    session[:restaurants] = params[:restaurants]
  end

  def populate_itinerary(itinerary)
    @items[:activities] = create_businesses(:activities)
    @items[:restaurants] = create_businesses(:restaurants)
    create_items(itinerary)
  end

  def create_businesses(group)
    return if session[group].blank?

    session[group].transform_values do |category|
      BusinessFacade.near(@geocode, category)
    end
  end

  def create_items(itinerary)
    return unless @items

    @items.each do |group, items|
      if %i[airports hospitals].include?(group)
        create_place_items(itinerary, items)
      elsif group == :parks
        create_park_items(itinerary, items)
      else
        create_business_items(itinerary, group, items)
      end
    end
  end

  def create_place_items(itinerary, items)
    items&.each { |place| itinerary.places.create!(place.serialized) }
  end

  def create_park_items(itinerary, items)
    items&.each { |item| itinerary.parks.create!(item.serialized) }
  end

  def create_business_items(itinerary, group, items)
    items&.each do |main, businesses|
      businesses&.each do |bus|
        itinerary.businesses.create!(bus.serialized.merge(group: group.to_s, main:))
      end
    end
  end
end
