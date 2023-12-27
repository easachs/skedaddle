# frozen_string_literal: true

module Redirection
  extend ActiveSupport::Concern

  def redirect_with_message(message: 'something', path: root_path)
    redirect_to path
    flash[:error] = t("flash.messages.#{message}")
  end
end
