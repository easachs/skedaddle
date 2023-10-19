# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page' do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      { 'provider' => 'google_oauth2',
        'uid' => '123456',
        'info' => {
          'name' => 'John Doe',
          'email' => 'johndoe@example.com'
        },
        'credentials' => {
          'token' => 'TOKEN'
        } }
    )
    visit root_path
    click_on('Log In')
  end

  it 'visits the home page, logs in and logs out' do
    click_on('Log Out')
    expect(page).to have_current_path(root_path)
  end
end
