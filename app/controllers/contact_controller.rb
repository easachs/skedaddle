# frozen_string_literal: true

class ContactController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.email(@contact).deliver_now
      redirect_to root_path
    else
      redirect_to contact_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
