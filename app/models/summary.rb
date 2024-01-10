# frozen_string_literal: true

# == Schema Information
#
# Table name: summaries
#
#  id           :bigint           not null, primary key
#  response     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  itinerary_id :bigint           not null
#
# Indexes
#
#  index_summaries_on_itinerary_id  (itinerary_id)
#
# Foreign Keys
#
#  fk_rails_...  (itinerary_id => itineraries.id)
#
class Summary < ApplicationRecord
  validates :response, presence: true
  belongs_to :itinerary
end
