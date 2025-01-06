# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard' do
  describe 'logs in' do
    before { mock_google_oauth2 }

    it 'and logs out' do
      within('#dash') { click_on 'Sign Out' }
      expect(page).to have_content('Welcome to Skedaddle')
    end
  end

  describe 'with invalid credentials' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        { 'provider' => 'google_oauth2',
          'uid' => '234567',
          'info' => {
            'name' => '',
            'email' => ''
          },
          'credentials' => {
            'token' => 'ANOTHER_TOKEN'
          } }
      )
      visit root_path
      within('#dash') { click_on 'Sign In' }
    end

    it 'redirects to log in if OAuth2 error' do
      click_on('Sign In with GoogleOauth2')
      expect(page).to have_content("Name can't be blank")
    end
  end
end
