# frozen_string_literal: true

class ItineraryService
  class << self
    def find_items(geocode)
      return unless geocode

      { airports: PlaceFacade.near(geocode, 'airport', 50_000),
        hospitals: PlaceFacade.near(geocode, 'hospital', 5_000) }
    end

    def populate(itinerary, items)
      items&.each do |group, resources|
        if %i[airports hospitals parks].include?(group)
          create_places(itinerary, group, resources)
        else
          create_businesses(itinerary, group, resources)
        end
      end
      remove_duplicate_businesses(itinerary)
    end

    def create_places(itinerary, group, resources)
      resources&.each { |item| itinerary.send(group).create!(item.serialized) }
    end

    def create_businesses(itinerary, group, resources)
      resources&.each do |kind, businesses|
        businesses&.each do |bus|
          itinerary.businesses.create!(bus.serialized.merge!(group: group.to_s, kind:))
        end
      end
    end

    def remove_duplicate_businesses(itinerary)
      names = {}

      itinerary.businesses.each do |bus|
        names[bus.name] ? bus.destroy : names[bus.name] = true
      end
    end
  end
end
