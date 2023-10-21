# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :not_logged_in

  private

  def not_logged_in
    return unless current_user.nil?

    redirect_to root_path
    flash[:error] = t('flash.errors.must_sign_in')
  end
end
