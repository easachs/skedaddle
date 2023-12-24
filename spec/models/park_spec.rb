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
require 'rails_helper'

RSpec.describe Park do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:activities) }
  end
end
