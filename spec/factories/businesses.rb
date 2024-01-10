# frozen_string_literal: true

# == Schema Information
#
# Table name: businesses
#
#  id           :bigint           not null, primary key
#  categories   :string
#  group        :string
#  kind         :string
#  location     :string
#  name         :string
#  phone        :string
#  price        :string
#  rating       :string
#  thumbnail    :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  itinerary_id :bigint           not null
#
# Indexes
#
#  index_businesses_on_itinerary_id  (itinerary_id)
#
# Foreign Keys
#
#  fk_rails_...  (itinerary_id => itineraries.id)
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
