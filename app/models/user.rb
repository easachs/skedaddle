# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  credit                 :integer          default(10)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
  has_many :itineraries, dependent: :destroy
  has_many :keys, dependent: :destroy

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid]) do |u|
      u.uid       = response[:uid]
      u.name      = response[:info][:name]
      u.email     = response[:info][:email]
      u.password  = Devise.friendly_token[0, 20]
    end
  end

  def openai_key = keys.find_by(name: 'openai')&.value
  def trailapi_key = keys.find_by(name: 'trailapi')&.value
end
