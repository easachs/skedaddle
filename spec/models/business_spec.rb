# frozen_string_literal: true

# == Schema Information
#
# Table name: businesses
#
#  id           :bigint           not null, primary key
#  categories   :string
#  favorited    :boolean          default(FALSE)
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
require 'rails_helper'

RSpec.describe Business do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_presence_of(:categories) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:group) }
    it { is_expected.to belong_to(:itinerary) }
  end
end
