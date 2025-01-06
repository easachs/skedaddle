# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id           :bigint           not null, primary key
#  amount       :integer          not null
#  payment_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  payment_id   :string           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Payment do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:payment_id) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:payment_type) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
  end
end
