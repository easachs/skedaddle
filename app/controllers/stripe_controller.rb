# frozen_string_literal: true

class StripeController < ApplicationController
  def checkout
    session = StripeService.checkout(email: stripe_params[:email],
                                     mode: stripe_params[:mode],
                                     root_url:)
    redirect_to session.url, allow_other_host: true
  end

  private

  def stripe_params = params.permit(:mode, :email)
end
