# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary Index' do
  before { mock_google_oauth2 }

  describe 'displays itineraries with', vcr: 'denver_search' do
    before do
      denver_search
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
