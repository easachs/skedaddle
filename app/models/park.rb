# frozen_string_literal: true

# == Schema Information
#
# Table name: parks
#
#  id           :bigint           not null, primary key
#  name         :string
#  location     :string
#  description  :string
#  directions   :string
#  activities   :string
#  url          :string
#  thumbnail    :string
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Park < ApplicationRecord
  validates :name, :location, :activities, presence: true
  belongs_to :itinerary
end
