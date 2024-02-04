# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id           :bigint           not null, primary key
#  address      :string
#  group        :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  itinerary_id :bigint           not null
#
# Indexes
#
#  index_places_on_itinerary_id  (itinerary_id)
#
# Foreign Keys
#
#  fk_rails_...  (itinerary_id => itineraries.id)
#
class Place < ApplicationRecord
  validates :name, :address, :group, presence: true
  belongs_to :itinerary
end
