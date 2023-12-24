# frozen_string_literal: true

module Redirection
  extend ActiveSupport::Concern

  def redirect_with_error(message: 'something', path: root_path)
    redirect_to path
    flash[:error] = t("flash.errors.#{message}")
  end
end
