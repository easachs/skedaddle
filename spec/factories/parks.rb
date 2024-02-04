# frozen_string_literal: true

# == Schema Information
#
# Table name: parks
#
#  id           :bigint           not null, primary key
#  activities   :string
#  description  :string
#  directions   :string
#  location     :string
#  name         :string
#  thumbnail    :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  itinerary_id :bigint           not null
#
# Indexes
#
#  index_parks_on_itinerary_id  (itinerary_id)
#
# Foreign Keys
#
#  fk_rails_...  (itinerary_id => itineraries.id)
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
