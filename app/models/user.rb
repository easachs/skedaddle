# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :email, presence: true
  has_many :itineraries, dependent: :destroy

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid]) do |u|
      u.uid = response[:uid]
      u.name = response[:info][:name]
      u.email = response[:info][:email]
      u.password = Devise.friendly_token[0, 20]
    end
  end
end
