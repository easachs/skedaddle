# frozen_string_literal: true

# == Schema Information
#
# Table name: itineraries
#
#  id         :bigint           not null, primary key
#  search     :string
#  city       :string
#  region     :string
#  country    :string
#  lat        :float
#  lon        :float
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Itinerary do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:search) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:businesses) }
    it { is_expected.to have_many(:parks) }
    it { is_expected.to have_many(:places) }
  end
end
