# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary New', vcr: 'denver_search' do
  before do
    mock_google_oauth2
    User.last.keys.create!(name: 'trailapi', value: ENV.fetch('RAPID_API_KEY', nil))
  end

  describe 'displays new itinerary with' do
    before { denver_search }

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
    before { denver_search && click_on('Save', match: :first) }

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
      before { visit '/itineraries/new?search=Nonexistent' }

      it 'redirects' do
        expect(page).to have_current_path(root_path)
      end

      it 'displays error' do
        expect(page).to have_content('No results.')
      end
    end

    describe 'with no search' do
      before { visit '/itineraries/new?search=' }

      it 'redirects' do
        expect(page).to have_current_path(root_path)
      end

      it 'displays error' do
        expect(page).to have_content('No results.')
      end
    end
  end
end
