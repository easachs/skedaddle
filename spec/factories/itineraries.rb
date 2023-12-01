# frozen_string_literal: true

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
