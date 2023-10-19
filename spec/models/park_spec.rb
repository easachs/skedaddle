# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:directions) }
    it { is_expected.to validate_presence_of(:activities) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
