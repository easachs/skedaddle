# frozen_string_literal: true

class Park < ApplicationRecord
  validates :name, :city, :country, :description, :directions, :lat, :lon, :activities, :url, presence: true
  belongs_to :itinerary
end
