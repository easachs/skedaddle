# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    @comment.save ? redirect_to(@post) : redirect_with_message(path: @post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
    redirect_to @post
  end

  private

  def set_post = @post = Post.find(params[:post_id])

  def comment_params = params.require(:comment).permit(:content)
end
