# frozen_string_literal: true

# == Schema Information
#
# Table name: summaries
#
#  id           :bigint           not null, primary key
#  response     :text
#  itinerary_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Summary do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:response) }
    it { is_expected.to belong_to(:itinerary) }
  end
end
