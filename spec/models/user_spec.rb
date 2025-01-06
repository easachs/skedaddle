# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  canceled               :boolean          default(FALSE), not null
#  credit                 :integer          default(10)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  subscribed             :boolean          default(FALSE), not null
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  subscription_id        :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:credit) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:itineraries) }
    it { is_expected.to have_many(:places).through(:itineraries) }
    it { is_expected.to have_many(:parks).through(:itineraries) }
    it { is_expected.to have_many(:businesses).through(:itineraries) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:payments) }
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

  describe 'instance methods' do
    let!(:user) { create(:user) }

    it 'has credit left' do
      expect(user.credit_left?).to be(true)
    end

    it 'can spend credit' do
      user.spend_credit!
      expect(user.credit).to be(9)
    end

    it 'can add credit' do
      user.add_credits(5)
      expect(user.credit).to be(15)
    end

    it 'has no credit' do
      10.times { user.spend_credit! }
      expect(user.credit).to be(0)
    end
  end
end
