# frozen_string_literal: true

FactoryBot.define do
  factory :park do
    name { Faker::Address.community }
    location { Faker::Address.city }
    description { Faker::Lorem.sentence }
    directions { Faker::Lorem.sentence }
    activities { Faker::Lorem.words(number: 2) }
    url { Faker::Internet.url }
  end
end
