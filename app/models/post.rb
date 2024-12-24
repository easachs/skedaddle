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
  validates :title, :city, presence: true
  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: false) }
end
