# frozen_string_literal: true

class KeysController < ApplicationController
  layout 'home'

  before_action :authenticate_user!

  def edit; end

  def update
    %i[openai trailapi].each do |key|
      user_key = current_user.keys.find_or_initialize_by(name: key.to_s)
      user_key.value = params[key]
      user_key.value == '' ? user_key.destroy : user_key.save
    end

    redirect_with_message(message: 'key_updated', path: keys_path)
  end
end
