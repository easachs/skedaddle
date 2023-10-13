# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :email, :uid, presence: true
  validates :email, :uid, uniqueness: true
  has_many :itineraries

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid]) do |u|
      u.uid = response[:uid]
      u.name = response[:info][:name]
      u.email = response[:info][:email]
      u.save
    end
  end
end
