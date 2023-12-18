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
