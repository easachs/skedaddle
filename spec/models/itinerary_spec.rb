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
require 'rails_helper'

RSpec.describe Itinerary do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:search) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:businesses) }
    it { is_expected.to have_many(:parks) }
    it { is_expected.to have_many(:places) }
    it { is_expected.to have_many(:summaries) }
  end
end
