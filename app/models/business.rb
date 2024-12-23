# frozen_string_literal: true

# == Schema Information
#
# Table name: businesses
#
#  id           :bigint           not null, primary key
#  categories   :string
#  favorited    :boolean          default(FALSE)
#  group        :string
#  kind         :string
#  location     :string
#  name         :string
#  phone        :string
#  price        :string
#  rating       :string
#  thumbnail    :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  itinerary_id :bigint           not null
#
# Indexes
#
#  index_businesses_on_itinerary_id  (itinerary_id)
#
# Foreign Keys
#
#  fk_rails_...  (itinerary_id => itineraries.id)
#
class Business < ApplicationRecord
  validates :name, :rating, :categories, :location, :group, :kind, presence: true
  belongs_to :itinerary
  scope :favorited, -> { where(favorited: true) }
end
