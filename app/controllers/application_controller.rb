# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Redirection

  before_action :configure_devise_parameters, if: :devise_controller?

  protected

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def authorize_admin
    return unless request.path.start_with?('/admin') && !current_user&.admin

    redirect_to root_path
    flash.now[:error] = t('flash.messages.no_access')
  end
end
