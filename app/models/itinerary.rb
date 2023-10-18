# frozen_string_literal: true

class Itinerary < ApplicationRecord
  validates :search, :city, :region, :country, :lat, :lon, presence: true
  belongs_to :user
  has_many :airports, dependent: :destroy
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy

  def date
    created_at.strftime('%m/%d/%y')
  end
end
