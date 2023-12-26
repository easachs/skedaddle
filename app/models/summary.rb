# frozen_string_literal: true

# == Schema Information
#
# Table name: summaries
#
#  id           :bigint           not null, primary key
#  response     :text
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Summary < ApplicationRecord
  validates :response, presence: true
  belongs_to :itinerary
end
