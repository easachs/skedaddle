# frozen_string_literal: true

class ContactController < ApplicationController
  include Redirection
  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.email(@contact).deliver_now
      redirect_to received_path
    else
      redirect_with_message(message: 'send_failed', path: contact_path)
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :message)
  end
end
