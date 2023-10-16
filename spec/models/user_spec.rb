# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:uid) }
  end

  describe 'class methods' do
    it 'from_omniauth' do
      response = { uid: '123456', info: { name: 'John Doe',
                                          email: 'johndoe@example.com' } }

      described_class.from_omniauth(response)

      expect(described_class.last.uid).to eq('123456')
      expect(described_class.last.name).to eq('John Doe')
      expect(described_class.last.email).to eq('johndoe@example.com')
    end
  end
end
