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
end
