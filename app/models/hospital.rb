# frozen_string_literal: true

class Hospital < ApplicationRecord
  validates :name, :address, presence: true
  belongs_to :itinerary
end
