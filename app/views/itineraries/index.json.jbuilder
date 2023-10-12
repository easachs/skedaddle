# frozen_string_literal: true

json.array! @itineraries, partial: 'itineraries/itinerary', as: :itinerary
