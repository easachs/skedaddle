# frozen_string_literal: true

FactoryBot.define do
  factory :business do
    name { Faker::Business.name }
    rating { rand(5) }
    price { '$' }
    thumbnail { Faker::Lorem.word }
    url { Faker::Lorem.word }
    categories { Faker::Lorem.words(number: 2) }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
