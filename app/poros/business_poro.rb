# frozen_string_literal: true

class BusinessPoro
  attr_reader :name, :rating, :price, :categories,:location, :phone, :url, :thumbnail

  def initialize(attributes = {})
    @name       = attributes&.dig(:name)
    @rating     = attributes&.dig(:rating)
    @price      = attributes&.dig(:price)
    @categories = attributes&.dig(:categories)&.map { _1&.dig(:title) }&.join(', ')
    @location   = attributes&.dig(:location, :display_address)&.join(', ')
    @phone      = attributes&.dig(:display_phone)
    @url        = attributes&.dig(:url)
    @thumbnail  = attributes&.dig(:image_url)
  end

  def serialized
    { name:, rating:, price:, categories:, location:, phone:, url:, thumbnail: }
  end
end
