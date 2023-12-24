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
#  kind         :string
#  group        :string
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
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
