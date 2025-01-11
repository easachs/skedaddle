# frozen_string_literal: true

# == Schema Information
#
# Table name: parks
#
#  id           :bigint           not null, primary key
#  activities   :string
#  description  :string
#  directions   :string
#  lat          :float
#  location     :string
#  lon          :float
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
require 'rails_helper'

RSpec.describe Park do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:activities) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:itinerary) }
  end
end
