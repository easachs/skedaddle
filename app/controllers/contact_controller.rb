# frozen_string_literal: true

class ContactController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.email(@contact).deliver_now
      redirect_to received_path
    else
      redirect_to contact_path
      flash[:error] = t('flash.errors.send_failed')
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :message)
  end
end
