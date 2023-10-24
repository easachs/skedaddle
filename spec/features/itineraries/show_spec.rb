# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Itinerary Show' do
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
    click_button('Sign In')
  end

  it 'redirects from nonexistent itinerary' do
    visit itinerary_path(999)
    expect(page).to have_current_path(itineraries_path)
  end

  describe 'removes', vcr: 'denver_search' do
    before do
      fill_in 'search', with: 'Denver'
      check 'Landmarks'
      check 'Bakeries'
      click_button 'SKEDADDLE'
      click_button 'Save'
    end

    it 'parks' do
      within '#parks' do
        click_button('Remove Black Forest Regional Park')
        expect(page).not_to have_content('Black Forest Regional Park')
      end
    end

    it 'restaurants' do
      within '#Bakeries' do
        click_button('Remove Izzio Bakery')
        expect(page).not_to have_content('Izzio Bakery')
      end
    end

    describe 'itinerary and' do
      before do
        click_button('Delete')
      end

      it 'redirects' do
        expect(page).to have_current_path(itineraries_path)
      end

      it 'deletes' do
        expect(page).not_to have_content('Denver')
      end
    end
  end
end
