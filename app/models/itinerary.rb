# frozen_string_literal: true

class Itinerary < ApplicationRecord
  validates :search, presence: true
  belongs_to :user
  has_many :parks, dependent: :destroy
  has_many :restaurants, dependent: :destroy
end
