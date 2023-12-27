# frozen_string_literal: true

require_relative 'boot'

require 'rails'

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module Skedaddle
  class Application < Rails::Application
    config.load_defaults 7.0
    config.generators.system_tests = nil
    config.exceptions_app = routes

    config.active_record.encryption.primary_key = ENV.fetch('ENCRYPTION_PRIMARY_KEY', nil)
    config.active_record.encryption.deterministic_key = ENV.fetch('ENCRYPTION_DETERMINISTIC_KEY', nil)
    config.active_record.encryption.key_derivation_salt = ENV.fetch('ENCRYPTION_KEY_DERIVATION_SALT', nil)
  end
end
