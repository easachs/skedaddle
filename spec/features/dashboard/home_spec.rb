# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page' do
  describe 'logs in' do
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
      within '#dash' do
        click_on('Sign In')
      end
      click_on('Sign In with GoogleOauth2')
    end

    it 'and logs out' do
      within '#dash' do
        click_on('Sign Out')
      end
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
      within '#dash' do
        click_on('Sign In')
      end
    end

    it 'redirects to log in if OAuth2 error' do
      click_on('Sign In with GoogleOauth2')
      expect(page).to have_content("Name can't be blank")
    end
  end
end
