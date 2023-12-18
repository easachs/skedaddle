# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id           :bigint           not null, primary key
#  name         :string
#  address      :string
#  main         :string
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Place < ApplicationRecord
  validates :name, :address, :main, presence: true
  belongs_to :itinerary
end
