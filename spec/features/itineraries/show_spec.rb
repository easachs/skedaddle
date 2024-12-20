# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary Show', vcr: 'denver_search' do
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
    User.last.keys.create!(name: 'openai', value: ENV.fetch('OPENAI_KEY', nil))
  end

  describe 'removes' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      within '#search-btn' do
        click_on 'SKEDADDLE'
      end
      click_on 'Save', match: :first
    end

    it 'parks' do
      within '#parks' do
        within '#park-black-forest-regional-park' do
          click_on('Remove')
        end
        expect(page).to have_no_content('Black Forest Regional Park')
      end
    end

    it 'restaurants' do
      within '#bakeries' do
        within '#business-lodough-bakery' do
          click_on('Remove')
        end
        expect(page).to have_no_content('LoDough Bakery')
      end
    end

    describe 'itinerary and' do
      before do
        click_on('Delete')
      end

      it 'redirects' do
        expect(page).to have_current_path(itineraries_path)
      end

      it 'deletes' do
        expect(page).to have_no_content('Denver')
      end
    end
  end

  describe 'creates summary', vcr: 'denver_update' do
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
      click_on 'Create Summary'
      expect(page).to have_content('Day 1:')
    end

    it 'with day parts' do
      click_on 'Create Summary'
      expect(page).to have_content('Morning:')
    end

    it 'with no key', vcr: 'bad_gptkey' do
      User.last.keys.find_by(name: 'openai').destroy
      click_on 'Create Summary'

      expect(page).to have_content('Invalid key.')
    end
  end

  describe 'nonexistent itinerary' do
    before do
      visit itinerary_path(999)
    end

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
