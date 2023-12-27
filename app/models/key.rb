# frozen_string_literal: true

# == Schema Information
#
# Table name: keys
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :string
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Key < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  encrypts :value, deterministic: true
end
