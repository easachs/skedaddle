# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:search) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:region) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
  end
end
