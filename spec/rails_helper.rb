# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require_relative 'support/feature_helpers'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec/fixtures').to_s]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include FeatureHelpers, type: :feature
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<GEOCODE_API_KEY>') { ENV.fetch('GEOCODE_API_KEY', nil) }
  config.filter_sensitive_data('<RAPID_API_KEY>') { ENV.fetch('RAPID_API_KEY', nil) }
  config.filter_sensitive_data('<YELP_API_KEY>') { ENV.fetch('YELP_API_KEY', nil) }
  config.filter_sensitive_data('<GOOGLE_MAPS_KEY>') { ENV.fetch('GOOGLE_MAPS_KEY', nil) }
  config.filter_sensitive_data('<WEATHER_API_KEY>') { ENV.fetch('WEATHER_API_KEY', nil) }
  config.filter_sensitive_data('<OPENAI_KEY>') { ENV.fetch('OPENAI_KEY', nil) }
  config.configure_rspec_metadata!
end
