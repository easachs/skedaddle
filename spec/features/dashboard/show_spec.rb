# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
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
  end

  it "visits the show page but it's not logged in SAD PATH" do
    visit '/dashboard'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Must be logged in.')
  end

  it 'visits the show page and logs out, happy path' do
    visit root_path

    click_on('Log In')

    expect(current_path).to eql('/dashboard')

    click_on('Log Out')

    expect(current_path).to eql(root_path)
  end
end
