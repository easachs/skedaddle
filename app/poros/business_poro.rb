# frozen_string_literal: true

class BusinessPoro
  attr_reader :name,
              :rating,
              :price,
              :categories,
              :location,
              :phone,
              :url,
              :thumbnail

  def initialize(attributes = {})
    @name = attributes[:name]
    @rating = attributes[:rating]
    @price = attributes[:price]
    @categories = attributes[:categories]&.map { _1[:title] }&.join(', ')
    @location = attributes.dig(:location, :display_address)&.join(', ')
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
      location: @location,
      phone: @phone,
      url: @url,
      thumbnail: @thumbnail
    }
  end
end
