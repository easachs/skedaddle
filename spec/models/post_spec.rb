# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  city       :string
#  content    :text
#  country    :string
#  published  :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Post do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:city) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:comments) }
  end
end
