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
    @itinerary = Itinerary.find(params[:id])
    redirect_to itineraries_path if @itinerary.user_id != current_user.id
  rescue StandardError
    redirect_to itineraries_path
  end

  def prepare
    initialize_session
    redirect_to new_itinerary_path
  end

  def new
    return unless session[:search].blank? || [@items].all?(&:blank?)

    redirect_to root_path
    flash[:error] = t('flash.errors.no_results')
  end

  def create
    itinerary = current_user.itineraries.create!(@geocode)
    populate(itinerary) if itinerary.persisted?
    redirect_to itinerary_path(itinerary)
  end

  def destroy
    Itinerary.find(params[:id]).destroy!
    redirect_to itineraries_path
  end

  private

  def initialize_session
    session[:search] = params[:search]
    session[:activities] = params[:activities]
    session[:restaurants] = params[:restaurants]
  end

  def geocode
    @geocode = GeocodeFacade.geocode(session[:search]&.delete("'"))
    @geocode&.merge(search: session[:search]) if @geocode&.dig(:search).blank?
  end

  def find_items
    return unless @geocode

    @items = {
      airports: PlaceFacade.near(@geocode, 'airport', 50_000),
      hospitals: PlaceFacade.near(@geocode, 'hospital'),
      parks: ParkFacade.near(@geocode),
      activities: find_businesses(:activities),
      restaurants: find_businesses(:restaurants)
    }
  end

  def find_businesses(group)
    return if group.blank? || session[group].blank?

    session[group].transform_values do |category|
      BusinessFacade.near(@geocode, category)
    end
  end

  def populate(itinerary)
    @items&.each do |group, items|
      if %i[airports hospitals parks].include?(group)
        create_special_items(itinerary, group, items)
      else
        create_business_items(itinerary, group, items)
      end
    end
  end

  def create_special_items(itinerary, group, items)
    items&.each { |item| itinerary.send(group).create!(item.serialized) }
  end

  def create_business_items(itinerary, group, items)
    items&.each do |main, businesses|
      businesses&.each do |bus|
        itinerary.businesses.create!(bus.serialized.merge(group: group.to_s, main:))
      end
    end
  end
end
