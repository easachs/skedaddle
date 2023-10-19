# frozen_string_literal: true

class Park < ApplicationRecord
  validates :name, :location, :directions, :description, :activities, :url, presence: true
  belongs_to :itinerary
end
