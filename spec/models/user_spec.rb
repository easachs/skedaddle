# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:itineraries) }
  end

  describe 'class methods' do
    describe 'from_omniauth' do
      before do
        response = { uid: '123456', info: { name: 'John Doe',
                                            email: 'johndoe@example.com' } }
        described_class.from_omniauth(response)
      end

      it 'returns uid' do
        expect(described_class.last.uid).to eq('123456')
      end

      it 'returns name' do
        expect(described_class.last.name).to eq('John Doe')
      end

      it 'returns email' do
        expect(described_class.last.email).to eq('johndoe@example.com')
      end
    end
  end
end
