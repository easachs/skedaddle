# frozen_string_literal: true

class Business < ApplicationRecord
  validates :name, :rating, :categories, :address, :phone, :url, presence: true
  belongs_to :itinerary
end