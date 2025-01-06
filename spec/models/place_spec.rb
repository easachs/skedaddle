# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id           :bigint           not null, primary key
#  address      :string
#  group        :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  itinerary_id :bigint           not null
#
# Indexes
#
#  index_places_on_itinerary_id  (itinerary_id)
#
# Foreign Keys
#
#  fk_rails_...  (itinerary_id => itineraries.id)
#
require 'rails_helper'

RSpec.describe Place do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:group) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:itinerary) }
  end
end
