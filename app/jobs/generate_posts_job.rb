# frozen_string_literal: true

class GeneratePostsJob < ApplicationJob
  queue_as :default

  def perform
    post = Post.draft.order(:created_at).first
    return unless post

    content = create_post(post.city)
    return unless content

    post.update!(title: "Discover #{post.city}",
                 content: content,
                 published: true)
  end

  private

  def create_post(city)
    return unless city

    GptService.blogpost(city)
  end
end
