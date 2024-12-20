# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM_ADDRESS', 'easachs13@gmail.com')
  layout 'mailer'
end
