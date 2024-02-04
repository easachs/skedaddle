# frozen_string_literal: true

# == Schema Information
#
# Table name: itineraries
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  end_date   :string
#  lat        :float
#  lon        :float
#  region     :string
#  search     :string
#  start_date :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_itineraries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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
