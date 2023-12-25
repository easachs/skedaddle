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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :email, :name, presence: true
  has_many :itineraries, dependent: :destroy

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid]) do |u|
      u.uid       = response[:uid]
      u.name      = response[:info][:name]
      u.email     = response[:info][:email]
      u.password  = Devise.friendly_token[0, 20]
    end
  end
end
