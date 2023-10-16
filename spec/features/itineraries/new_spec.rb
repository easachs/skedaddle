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

  it 'has search location and parks/restaurants displayed', vcr: 'denver_search' do
    expect(page).to have_current_path(dashboard_path)
    visit '/itineraries/new?search=Denver'
    expect(page).to have_content('DENVER Itinerary')
    within '#parks' do
      expect(page).to have_content('Apex Park')
      expect(page).to have_content('Bear Creek Regional Park')
      expect(page).to have_content('Black Forest Regional Park')
    end

    within '#restaurants' do
      expect(page).to have_content('Rating:')
      expect(page).to have_content('Price:')
      expect(page).to have_content('Categories:')
      expect(page).to have_content('Location:')
      expect(page).to have_content('Phone:')
    end
    click_on('Save')
    expect(page).to have_content('DENVER Itinerary')
    within '#parks' do
      expect(page).to have_content('Apex Park')
      expect(page).to have_content('Bear Creek Regional Park')
      expect(page).to have_content('Black Forest Regional Park')
    end

    within '#restaurants' do
      expect(page).to have_content('Rating:')
      expect(page).to have_content('Price:')
      expect(page).to have_content('Categories:')
      expect(page).to have_content('Location:')
      expect(page).to have_content('Phone:')
    end
    click_on('Itineraries')
    expect(page).to have_current_path(itineraries_path)
    expect(page).to have_content('My Itineraries')
    expect(page).to have_content('DENVER')
    click_on('DENVER')
    expect(page).to have_content('DENVER Itinerary')
    click_on('Delete')
    expect(page).to have_current_path(itineraries_path)
    expect(page).not_to have_content('DENVER')

    click_on('Log Out')
    visit itineraries_path
    expect(page).to have_content('Must be logged in.')
    expect(page).to have_current_path(root_path)
  end

  it 'itinerary with no search SAD PATH', vcr: 'empty_search' do
    expect(page).to have_current_path(dashboard_path)

    visit '/itineraries/new?search='
    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content('No results found.')
  end

  it 'itinerary with no results SAD PATH', vcr: 'bad_search' do
    expect(page).to have_current_path(dashboard_path)

    visit '/itineraries/new?search=Nonexistent'
    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content('No results found.')
  end
end
