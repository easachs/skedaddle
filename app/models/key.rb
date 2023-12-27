# frozen_string_literal: true

class Key < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  encrypts :value, deterministic: true
end
