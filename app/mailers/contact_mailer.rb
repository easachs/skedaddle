# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def email(contact)
    @name     = contact.name
    @email    = contact.email
    @message  = contact.message
    mail(to: 'easachs13@gmail.com',
         subject: t('mailers.contact.subject'))
  end
end
