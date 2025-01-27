# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = :info

  config.log_tags = [:request_id]

  config.cache_store = :redis_cache_store, {
    url: ENV.fetch('REDIS_URL', nil),
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }

  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    domain: 'skedaddle.herokuapp.com',
    user_name: 'apikey',
    password: ENV.fetch('SENDGRID_API_KEY', nil),
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: 'skedaddle.herokuapp.com' }

  config.i18n.fallbacks = true

  config.active_support.report_deprecations = false

  config.log_formatter = Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.assets.css_compressor = nil
end
