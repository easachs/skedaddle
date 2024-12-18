# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary New', vcr: 'denver_search' do
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

    User.last.keys.create!(name: 'trailapi', value: ENV.fetch('RAPID_API_KEY', nil))
  end

  describe 'displays new itinerary with' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      within '#search-btn' do
        click_on 'SKEDADDLE'
      end
    end

    it 'title' do
      expect(page).to have_content('Denver')
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

  describe 'saves new itinerary with' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      within '#search-btn' do
        click_on 'SKEDADDLE'
      end
      click_on 'Save', match: :first
    end

    it 'title' do
      expect(page).to have_content('Denver')
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
        expect(page).to have_content('No results.')
      end
    end

    describe 'with no search' do
      before do
        visit '/itineraries/new?search='
      end

      it 'redirects' do
        expect(page).to have_current_path(root_path)
      end

      it 'displays error' do
        expect(page).to have_content('No results.')
      end
    end
  end
end
