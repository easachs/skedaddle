# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show Itinerary' do
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

    click_on('Log In')
  end

  it 'can delete parks and businesses', vcr: 'denver_search' do
    expect(page).to have_current_path(root_path)
    visit '/itineraries/new?search=Denver'
    expect(page).to have_content('Denver, CO, USA Itinerary')
    click_on('Save')

    expect(page).to have_content('Denver, CO, USA Itinerary')
    within '#parks' do
      expect(page).to have_content('Apex Park')
      expect(page).to have_content('Bear Creek Regional Park')
      expect(page).to have_content('Black Forest Regional Park')
      click_on('Remove Black Forest Regional Park')

      expect(page).to have_content('Apex Park')
      expect(page).to have_content('Bear Creek Regional Park')
      expect(page).not_to have_content('Black Forest Regional Park')
    end

    within '#businesses' do
      expect(page).to have_content('Meadow Lark Farm Dinners')
      expect(page).to have_content('Fanwich Food Truck')
      expect(page).to have_content('Little Bodega')
      click_on('Remove Little Bodega')

      expect(page).to have_content('Meadow Lark Farm Dinners')
      expect(page).to have_content('Fanwich Food Truck')
      expect(page).not_to have_content('Little Bodega')
    end
  end
end
