# frozen_string_literal: true

module FeatureHelpers
  def mock_google_oauth2
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
  end

  def denver_search
    fill_in 'search', with: 'Denver'
    check 'Landmarks'
    check 'Bakeries'
    click_on 'SKEDADDLE'
  end

  def nav_to_admin
    User.last.update!(admin: true)
    visit admin_root_path
  end
end
