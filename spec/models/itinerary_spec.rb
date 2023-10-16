# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:locality) }
    it { is_expected.to validate_presence_of(:region) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
  end
end
