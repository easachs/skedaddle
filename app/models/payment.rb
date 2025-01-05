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
class Payment < ApplicationRecord
  validates :payment_id, :amount, :payment_type, presence: true
  belongs_to :user

  enum :payment_type, { onetime: 'onetime', subscription: 'subscription' }
end
