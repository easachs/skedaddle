# frozen_string_literal: true

class TestController < ApplicationController
  layout 'test'

  def test
    @posts = Post.published
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(4)

    return unless current_user

    @itineraries = current_user.itineraries
                               .order(created_at: :desc)
                               .page(params[:page])
                               .per(8)
  end

  def sign_in; end
  def sign_up; end
end
