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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :email, :name, presence: true
  validates :credit, numericality: { greater_than_or_equal_to: 0 }
  has_many :itineraries, dependent: :destroy
  has_many :places, through: :itineraries
  has_many :parks, through: :itineraries
  has_many :businesses, through: :itineraries
  has_many :comments, dependent: :destroy
  has_many :payments, dependent: :destroy

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid]) do |user|
      user.uid       = response[:uid]
      user.name      = response[:info][:name]
      user.email     = response[:info][:email]
      user.password  = Devise.friendly_token[0, 20]
    end
  end

  def credit_left? = subscribed? || credit.positive?

  def spend_credit!
    update!(credit: credit - 1) unless subscribed?
  end

  def add_credits(amount) = update!(credit: credit + amount)

  def cancel_subscription!
    return if subscription_id.blank?

    Stripe::Subscription.update(subscription_id, cancel_at_period_end: true)
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error "Subscription Cancellation Failed: #{e.message}"
    false
  end

  def resume_subscription!
    return if subscription_id.blank?

    Stripe::Subscription.update(subscription_id, cancel_at_period_end: false)
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error "Failed to resume subscription: #{e.message}"
    false
  end
end
