# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:directions) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
    it { is_expected.to validate_presence_of(:activities) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
