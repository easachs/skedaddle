# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts =  Post.published
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per(8)
  end

  def show
    @post = Post.find(params[:id])
  end
end
