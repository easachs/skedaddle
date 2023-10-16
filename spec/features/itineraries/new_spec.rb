# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New Itinerary' do
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

  it 'displays new itinerary', vcr: 'denver_search' do
    visit '/itineraries/new?search=Denver'
    expect(page).to have_content('Denver Itinerary')

    within '#parks' do
      expect(page).to have_content('Apex Park')
      expect(page).to have_content('Bear Creek Regional Park')
      expect(page).to have_content('Black Forest Regional Park')
    end

    within '#businesses' do
      expect(page).to have_content('Meadow Lark Farm Dinners')
      expect(page).to have_content('Fanwich Food Truck')
      expect(page).to have_content('Little Bodega')
    end

    click_on('Save')

    expect(page).to have_content('Denver Itinerary')

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

    click_on('Itineraries')

    expect(page).to have_current_path(itineraries_path)
    expect(page).to have_content('Itineraries')
    expect(page).to have_content('Denver')

    click_on('Denver')

    expect(page).to have_content('Denver Itinerary')

    click_on('Delete')

    expect(page).to have_current_path(itineraries_path)
    expect(page).not_to have_content('Denver')

    click_on('Log Out')
    visit itineraries_path

    expect(page).to have_content('Must be logged in.')
    expect(page).to have_current_path(root_path)
  end

  it 'itinerary with no search sad path', vcr: 'empty_search' do
    visit '/itineraries/new?search='
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('No results found.')
  end

  it 'itinerary with no results sad path', vcr: 'bad_search' do
    visit '/itineraries/new?search=Nonexistent'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('No results found.')
  end
end
