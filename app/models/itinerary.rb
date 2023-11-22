# frozen_string_literal: true

class Itinerary < ApplicationRecord
  validates :search, :city, :region, :country, :lat, :lon, presence: true
  belongs_to :user
  has_many :places, dependent: :destroy
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy

  def date
    created_at.strftime('%m/%d/%y')
  end

  def airports
    places.where(main: 'airport')
  end

  def hospitals
    places.where(main: 'hospital')
  end

  def activities
    businesses.where(group: 'activities')
              .group_by(&:main)
  end

  def restaurants
    businesses.where(group: 'restaurants')
              .group_by(&:main)
  end
end
