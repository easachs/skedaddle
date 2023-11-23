# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary New' do
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

  describe 'displays new itinerary with', vcr: 'denver_search' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      click_button 'SKEDADDLE'
    end

    it 'title' do
      expect(page).to have_content('Denver Itinerary')
    end

    it 'parks' do
      within '#parks' do
        expect(page).to have_content('Bear Creek Regional Park')
      end
    end

    it 'restaurants' do
      within '#bakeries' do
        expect(page).to have_content('The Denver Central Market')
      end
    end
  end

  describe 'saves new itinerary with', vcr: 'denver_search' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      click_button 'SKEDADDLE'
      click_button 'Save'
    end

    it 'title' do
      expect(page).to have_content('Denver Itinerary')
    end

    it 'parks' do
      within '#parks' do
        expect(page).to have_content('Bear Creek Regional Park')
      end
    end

    it 'restaurants' do
      within '#bakeries' do
        expect(page).to have_content('The Denver Central Market')
      end
    end
  end

  describe 'sad path' do
    describe 'with no results', vcr: 'bad_geocode' do
      before do
        visit '/itineraries/new?search=Nonexistent'
      end

      it 'redirects' do
        expect(page).to have_current_path(root_path)
      end

      it 'displays error' do
        expect(page).to have_content('No results found.')
      end
    end

    describe 'with no search', vcr: 'blank_search' do
      before do
        visit '/itineraries/new?search='
      end

      it 'redirects' do
        expect(page).to have_current_path(root_path)
      end

      it 'displays error' do
        expect(page).to have_content('No results found.')
      end
    end
  end
end
