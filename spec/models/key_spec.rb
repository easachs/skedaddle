# frozen_string_literal: true

# == Schema Information
#
# Table name: keys
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_keys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Key do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to belong_to(:user) }
  end
end
