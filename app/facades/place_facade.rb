# frozen_string_literal: true

class PlaceFacade
  class << self
    def near(location = {}, group = '', radius = 5000)
      return unless location.is_a?(Hash) && location.present? && group.present?

      places = PlaceService.near(location, group, radius)
      items = places[:places] if places.present?
      items[0..1].map { |place| PlacePoro.new(place.merge(group:)) } if items.present?
    end
  end
end
