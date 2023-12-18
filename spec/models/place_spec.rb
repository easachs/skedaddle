# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id           :bigint           not null, primary key
#  name         :string
#  address      :string
#  main         :string
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Place do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:main) }
  end
end
