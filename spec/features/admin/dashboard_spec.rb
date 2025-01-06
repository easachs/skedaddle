# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Active Admin Dashboard' do
  describe 'admin' do
    before { mock_google_oauth2 && nav_to_admin }

    describe 'content' do
      it 'has welcome message' do
        expect(page).to have_content('Welcome to Active Admin.')
      end
    end

    describe 'links' do
      it 'has link to dashboard' do
        expect(page).to have_selector(:link, 'Dashboard')
      end

      it 'has link to posts' do
        expect(page).to have_selector(:link, 'Posts')
      end
    end
  end

  describe 'unauthorized' do
    before { mock_google_oauth2 && visit(admin_root_path) }

    it 'gets redirected' do
      expect(page).to have_current_path(root_path)
    end
  end
end
