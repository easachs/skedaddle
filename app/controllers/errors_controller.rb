# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout 'home'

  def not_found
    render status: :not_found
  end

  def internal_error
    render status: :internal_server_error
  end

  def unprocessable
    redirect_with_message
  end
end
