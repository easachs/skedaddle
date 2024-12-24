# frozen_string_literal: true

class GeneratePostsJob < ApplicationJob
  queue_as :default

  def perform
    api_key = ENV.fetch('OPENAI_KEY')
    service = GptService.new(api_key)

    post = Post.draft.order(:created_at).first
    return unless post

    content = service.blogpost(post.city)
    return unless content

    post.update!(title: "Discover #{post.city}",
                 content: content,
                 published: true)
  end
end
