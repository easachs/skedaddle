# frozen_string_literal: true

# == Schema Information
#
# Table name: itineraries
#
#  id         :bigint           not null, primary key
#  search     :string
#  city       :string
#  region     :string
#  country    :string
#  lat        :float
#  lon        :float
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :itinerary do
    search { Faker::Address.city }
    city { Faker::Address.city }
    region { Faker::Address.state }
    country { Faker::Address.country }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    user
  end
end
