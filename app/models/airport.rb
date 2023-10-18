# frozen_string_literal: true

class Airport < ApplicationRecord
  validates :name, :address2, presence: true
  belongs_to :itinerary
end
