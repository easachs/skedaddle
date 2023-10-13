# frozen_string_literal: true

class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :message

  validates :name, :email, :subject, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
