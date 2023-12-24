# frozen_string_literal: true

# == Schema Information
#
# Table name: businesses
#
#  id           :bigint           not null, primary key
#  name         :string
#  rating       :string
#  price        :string
#  categories   :string
#  location     :string
#  phone        :string
#  url          :string
#  thumbnail    :string
#  main         :string
#  group        :string
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Business do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_presence_of(:categories) }
    it { is_expected.to validate_presence_of(:location) }
  end
end
