# frozen_string_literal: true

# == Schema Information
#
# Table name: summaries
#
#  id           :bigint           not null, primary key
#  kind         :integer          default("plan"), not null
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
  enum :kind, { plan: 0, info: 1 }
  validates :response, :kind, presence: true
  belongs_to :itinerary
end
