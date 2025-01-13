# frozen_string_literal: true

class ContactController < ApplicationController
  layout 'home'

  def contact; end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.email(@contact).deliver_now
      redirect_to received_path
    else
      redirect_with_message(message: 'send_failed', path: contact_path)
    end
  end

  def received; end

  private

  def contact_params
    params.permit(:name, :email, :message)
  end
end
