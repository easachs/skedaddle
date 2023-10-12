# frozen_string_literal: true

json.extract! park, :id, :name, :city, :state, :country, :description, :directions, :lat, :lon, :activities, :url,
              :thumbnail, :itinerary_id, :created_at, :updated_at
json.url park_url(park, format: :json)
