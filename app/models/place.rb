# frozen_string_literal: true

class Place < ApplicationRecord
  validates :name, :address, :main, presence: true
  belongs_to :itinerary
end
