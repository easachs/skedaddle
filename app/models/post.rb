# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  city       :string
#  content    :text
#  published  :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :city, presence: true
  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: false) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[city content created_at id id_value published title updated_at]
  end
end
