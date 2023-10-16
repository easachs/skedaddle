# frozen_string_literal: true

class Itinerary < ApplicationRecord
  validates :label, :locality, :region, :country, presence: true
  belongs_to :user
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy
end
