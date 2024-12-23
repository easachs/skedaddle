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
    click_on('Sign In with GoogleOauth2')
  end

  describe 'displays itineraries with', vcr: 'denver_search' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      within('#search-btn') { click_on 'SKEDADDLE' }
      click_on 'Save', match: :first
      visit itineraries_path
    end

    it 'title' do
      expect(page).to have_content('Itineraries')
    end

    it 'links' do
      click_on('Denver')
      expect(page).to have_content('Denver')
    end
  end

  describe 'signed out' do
    before do
      within('#dash') { click_on 'Sign Out' }
      visit itineraries_path
    end

    it 'redirects' do
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'displays error' do
      expect(page).to have_content('You need to sign in.')
    end
  end
end
