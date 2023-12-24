# frozen_string_literal: true

class ItineraryService
  class << self
    def find_items(geocode)
      return unless geocode

      { airports: PlaceFacade.near(geocode, 'airport', 50_000),
        hospitals: PlaceFacade.near(geocode, 'hospital'),
        parks: ParkFacade.near(geocode) }
    end

    def populate(itinerary, items)
      items&.each do |group, resources|
        if %i[airports hospitals parks].include?(group)
          create_places(itinerary, group, resources)
        else
          create_businesses(itinerary, group, resources)
        end
      end
    end

    def create_places(itinerary, group, resources)
      resources&.each { |item| itinerary.send(group).create!(item.serialized) }
    end

    def create_businesses(itinerary, group, resources)
      resources&.each do |main, businesses|
        businesses&.each do |bus|
          itinerary.businesses.create!(bus.serialized.merge!(group: group.to_s, main:))
        end
      end
    end
  end
end
