# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:message) }
  end
end
