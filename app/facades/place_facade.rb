# frozen_string_literal: true

class PlaceFacade
  class << self
    def near(location = {}, main = '', radius = 5000)
      return unless location.is_a?(Hash) && location.present?
      return if main.blank?

      places = PlaceService.near(location, main, radius)
      items = places[:places] if places.present?
      items[0..1].map { |place| PlacePoro.new(place.merge(main:)) } if items.present?
    end
  end
end
