# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :not_logged_in, only: [:dashboard]

  def home
    redirect_to dashboard_path if current_user
  end

  def dashboard; end

  def about_us; end
end
