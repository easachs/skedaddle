# frozen_string_literal: true

class StripeController < ApplicationController
  before_action :authenticate_user!
  def checkout
    session = StripeService.checkout(email: stripe_params[:email],
                                     mode: stripe_params[:mode],
                                     root_url:)
    redirect_to session.url, allow_other_host: true
  end

  def cancel
    if current_user.cancel_subscription!
      redirect_with_message(message: 'canceled')
    else
      redirect_with_message(message: 'cancel_error')
    end
  end

  def resub
    if current_user.resume_subscription!
      redirect_with_message(message: 'resubbed')
    else
      redirect_with_message(message: 'resub_error')
    end
  end

  private

  def stripe_params = params.permit(:mode, :email)
end
