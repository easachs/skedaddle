# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :not_logged_in

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def not_logged_in
    return unless current_user.nil?

    redirect_to root_path
    flash[:error] = 'Must be logged in.'
  end
end
