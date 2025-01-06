# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Active Admin Posts' do
  before do
    mock_google_oauth2
    Post.create(city: 'Denver')
    nav_to_admin
    click_on('Posts')
  end

  describe 'has posts' do
    it 'indexed' do
      expect(page).to have_content('Denver')
    end

    it 'has link to view' do
      expect(page).to have_selector(:link, 'View')
    end

    it 'has link to edit' do
      expect(page).to have_selector(:link, 'Edit')
    end

    it 'has link to delete' do
      expect(page).to have_selector(:link, 'Delete')
    end
  end

  describe 'has links to' do
    it 'show post' do
      click_on 'View', match: :first
      expect(page).to have_content('Post Details')
    end

    it 'edit post' do
      click_on 'Edit', match: :first
      expect(page).to have_css("input[type=submit][value='Update Post']")
    end
  end
end
