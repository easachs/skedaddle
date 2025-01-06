# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary Show', vcr: 'denver_search' do
  before { mock_google_oauth2 }

  describe 'has tab for' do
    before { denver_search && click_on('Save', match: :first) }

    it 'places' do
      expect(page).to have_selector(:button, 'PLACES')
    end

    it 'info' do
      expect(page).to have_selector(:button, 'INFO')
    end

    it 'map' do
      expect(page).to have_selector(:button, 'MAP')
    end

    it 'plan' do
      expect(page).to have_selector(:button, 'PLAN')
    end
  end

  describe 'features' do
    before { denver_search && click_on('Save', match: :first) }

    describe 'favorite' do
      let(:bakery) { Business.find_by(name: 'LoDough Bakery') }

      it 'begins unfavorited' do
        expect(bakery.favorited?).to be(false)
      end

      it 'can favorite a business' do
        within '#business-lodough-bakery' do
          click_on '☆'
        end
        expect(bakery.favorited?).to be(true)
      end
    end
  end

  describe 'removes' do
    before { denver_search && click_on('Save', match: :first) }

    it 'parks' do
      within '#park-black-forest-regional-park' do
        click_on '✖', match: :first
        within('#removal') { click_on 'Delete' }
      end
      expect(page).to have_no_content('Black Forest Regional Park')
    end

    it 'restaurants' do
      within '#business-lodough-bakery' do
        click_on '✖', match: :first
        within('#removal') { click_on 'Delete' }
      end
      expect(page).to have_no_content('LoDough Bakery')
    end

    describe 'itinerary and' do
      before do
        within '#itinerary-delete' do
          click_on 'Delete', match: :first
          within('#modal') { click_on 'Delete' }
        end
      end

      it 'redirects' do
        expect(page).to have_current_path(itineraries_path)
      end

      it 'deletes' do
        expect(page).to have_no_content('Denver')
      end
    end
  end

  describe 'creates plan' do
    before { denver_search && click_on('Save', match: :first) }

    it 'with days' do
      click_on 'Create Plan'
      expect(page).to have_content('Day 1:')
    end

    it 'with day parts' do
      click_on 'Create Plan'
      expect(page).to have_content('Morning:')
    end
  end

  describe 'nonexistent itinerary' do
    before { visit itinerary_path(999) }

    it 'redirects to itineraries' do
      expect(page).to have_current_path(itineraries_path)
    end

    it 'displays error' do
      expect(page).to have_content('Not found.')
    end
  end

  describe 'restricted itinerary' do
    before do
      not_you = create(:user)
      not_your_itinerary = create(:itinerary, user: not_you)
      visit itinerary_path(not_your_itinerary)
    end

    it 'redirects to itineraries' do
      expect(page).to have_current_path(itineraries_path)
    end

    it 'displays error' do
      expect(page).to have_content("This isn't yours.")
    end
  end
end
