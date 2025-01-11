# frozen_string_literal: true

# == Schema Information
#
# Table name: itineraries
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  end_date   :string
#  lat        :float
#  lon        :float
#  region     :string
#  search     :string
#  start_date :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_itineraries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Itinerary < ApplicationRecord
  validates :search, :city, :lat, :lon, :start_date, :end_date, presence: true
  belongs_to :user
  has_many :places, dependent: :destroy
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy
  has_many :summaries, dependent: :destroy

  def created     = created_at.strftime('%m/%d/%y')
  def coordinates = { lat:, lon: }

  def airports    = places.where(group: 'airport')
  def hospitals   = places.where(group: 'hospital')
  def activities  = businesses.where(group: 'activities').group_by(&:kind)
  def restaurants = businesses.where(group: 'restaurants').group_by(&:kind)

  def items       = { airports:, hospitals:, parks:, activities:, restaurants: }
  def info        = summaries.find_by(kind: 'info')
  def plan        = summaries.find_by(kind: 'plan')

  def map_items
    items = businesses + parks
    points = {}
    items.map do |item|
      next if item.lat.nil? || item.lon.nil?
      points[item.name] = { lat: item.lat, lon: item.lon }
    end
    points.to_json
  end

  # create
  def self.create_for_user!(user, geocode, items)
    itinerary = user.itineraries.create!(geocode)
    itinerary.populate(items) if itinerary.persisted?
    itinerary.summaries.create!(response: GptService.info(itinerary.city), kind: 'info')
    itinerary
  end

  def populate(items)
    items&.each do |group, resources|
      if %i[airports hospitals parks].include?(group)
        create_places(group, resources)
      else
        create_businesses(group, resources)
      end
    end
    remove_duplicate_businesses
  end

  def create_places(group, resources)
    resources&.each { |item| send(group).create!(item.serialized) }
  end

  def create_businesses(group, resources)
    resources&.each do |kind, buss|
      buss&.each do |bus|
        businesses.create!(bus.serialized.merge!(group: group.to_s, kind:))
      end
    end
  end

  def remove_duplicate_businesses
    names = {}

    businesses.each do |bus|
      names[bus.name] ? bus.destroy : names[bus.name] = true
    end
  end

  # update
  def fresh_plan!
    return unless user.credit_left?

    user.spend_credit!
    plan&.destroy
    summaries.create!(response: GptService.plan(decorate), kind: 'plan')
  end
end
