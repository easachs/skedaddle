# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_presence_of(:categories) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
