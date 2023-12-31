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
#  start_date :string
#  end_date   :string
#
FactoryBot.define do
  factory :itinerary do
    search { Faker::Address.city }
    city { Faker::Address.city }
    region { Faker::Address.state }
    country { Faker::Address.country }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    start_date { '12/25/23' }
    end_date { '12/27/23' }
    user
  end
end
