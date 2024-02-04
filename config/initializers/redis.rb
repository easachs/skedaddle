# frozen_string_literal: true

$redis = Redis.new(url: ENV.fetch('REDISCLOUD_URL', nil)) if ENV.fetch('REDISCLOUD_URL', nil)
