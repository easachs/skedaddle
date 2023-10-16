# frozen_string_literal: true

class Itinerary < ApplicationRecord
  validates :label, :locality, :region, :country, :lat, :lon, presence: true
  belongs_to :user
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy

  def date
    created_at.strftime('%m/%d/%y')
  end
end
