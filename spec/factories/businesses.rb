# frozen_string_literal: true

FactoryBot.define do
  factory :business do
    name { Faker::Business.name }
    rating { rand(5) }
    url { Faker::Lorem.word }
    categories { Faker::Lorem.word }
    location { Faker::Address.city }
    url { Faker::Internet.url }
  end
end
