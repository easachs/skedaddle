# frozen_string_literal: true

# == Schema Information
#
# Table name: businesses
#
#  id           :bigint           not null, primary key
#  name         :string
#  rating       :string
#  price        :string
#  categories   :string
#  location     :string
#  phone        :string
#  url          :string
#  thumbnail    :string
#  main         :string
#  group        :string
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Business < ApplicationRecord
  validates :name, :rating, :categories, :location, :url, presence: true
  belongs_to :itinerary
end
