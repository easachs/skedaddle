# frozen_string_literal: true

json.extract! restaurant, :id, :name, :rating, :price, :categories, :address, :phone, :url, :thumbnail, :itinerary_id,
              :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
