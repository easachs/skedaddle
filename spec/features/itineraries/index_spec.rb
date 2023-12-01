# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary Index' do
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
    visit new_user_session_path
    click_button('Sign In with GoogleOauth2')
  end

  describe 'displays itineraries with', vcr: 'denver_search' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      click_button 'SKEDADDLE'
      click_button 'Save'
      visit itineraries_path
    end

    it 'title' do
      expect(page).to have_content('Itineraries')
    end

    it 'links' do
      click_link('Denver')
      expect(page).to have_content('Denver Itinerary')
    end
  end

  describe 'signed out' do
    before do
      click_button('Sign Out')
      visit itineraries_path
    end

    it 'redirects' do
      expect(page).to have_current_path(root_path)
    end

    it 'displays error' do
      expect(page).to have_content('Must sign in.')
    end
  end
end
