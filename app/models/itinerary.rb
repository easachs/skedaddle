# frozen_string_literal: true

# == Schema Information
#
# Table name: itineraries
#
#  id         :bigint           not null, primary key
#  search     :string
#  city       :string
#  region     :string
#  country    :string
#  lat        :float
#  lon        :float
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Itinerary < ApplicationRecord
  validates :search, :city, :lat, :lon, presence: true
  belongs_to :user
  has_many :places, dependent: :destroy
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy

  def date = created_at.strftime('%m/%d/%y')

  def airports = places.where(main: 'airport')
  def hospitals = places.where(main: 'hospital')
  def activities = businesses.where(group: 'activities').group_by(&:main)
  def restaurants = businesses.where(group: 'restaurants').group_by(&:main)

  def items = { airports:, hospitals:, parks:, activities:, restaurants: }
end
