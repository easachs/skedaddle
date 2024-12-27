# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary Show', vcr: 'denver_search' do
  before do
    mock_google_oauth2
    User.last.keys.create!(name: 'trailapi', value: ENV.fetch('RAPID_API_KEY', nil))
    User.last.keys.create!(name: 'openai', value: ENV.fetch('OPENAI_KEY', nil))
  end

  describe 'removes' do
    before { denver_search && click_on('Save', match: :first) }

    it 'parks' do
      within '#park-black-forest-regional-park' do
        click_on '✖', match: :first
        within('#removal') { click_on 'Remove' }
      end
      expect(page).to have_no_content('Black Forest Regional Park')
    end

    it 'restaurants' do
      within '#business-lodough-bakery' do
        click_on '✖', match: :first
        within('#removal') { click_on 'Remove' }
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

  describe 'creates plan', vcr: 'denver_update' do
    before do
      current_user = User.last
      itinerary = current_user.itineraries.create(search: 'Denver, CO, USA',
                                                  city: 'Denver',
                                                  lat: 39.740959,
                                                  lon: -104.985798,
                                                  start_date: '12/25/23',
                                                  end_date: '12/27/23')
      visit itinerary_path(itinerary)
    end

    it 'with days' do
      click_on 'Create Plan'
      expect(page).to have_content('Day 1:')
    end

    it 'with day parts' do
      click_on 'Create Plan'
      expect(page).to have_content('Morning:')
    end

    it 'with no key', vcr: 'bad_gptkey' do
      User.last.keys.find_by(name: 'openai').destroy
      click_on 'Create Plan'

      expect(page).to have_content('Invalid key.')
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
