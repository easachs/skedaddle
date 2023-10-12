# frozen_string_literal: true

json.extract! itinerary, :id, :search, :user_id, :created_at, :updated_at
json.url itinerary_url(itinerary, format: :json)
