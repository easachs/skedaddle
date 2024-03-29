# frozen_string_literal: true

require 'capybara/rspec'
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/rails_helper.rb'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  #   config.profile_examples = 10
  #   config.order = :random
end
