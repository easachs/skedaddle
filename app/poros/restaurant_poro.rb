# frozen_string_literal: true

class RestaurantPoro
  attr_reader :name,
              :rating,
              :price,
              :categories,
              :address,
              :phone,
              :url,
              :thumbnail

  def initialize(attributes = {})
    @name = attributes[:name]
    @rating = attributes[:rating]
    @price = attributes[:price]
    @categories = attributes[:categories]&.map { _1[:title] }&.join(', ')
    @address = attributes.dig(:location, :display_address)&.join(', ')
    @phone = attributes[:display_phone]
    @url = attributes[:url]
    @thumbnail = attributes[:image_url]
  end

  def serialized
    {
      name: @name,
      rating: @rating,
      price: @price,
      categories: @categories,
      address: @address,
      phone: @phone,
      url: @url,
      thumbnail: @thumbnail
    }
  end
end
