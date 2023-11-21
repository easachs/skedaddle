# frozen_string_literal: true

class PlacesFacade
  def self.places_near(location = {}, main = '')
    return unless location.is_a?(Hash) && location.present?
    return if main.blank?

    places = PlacesService.places_near(location, main)
    items = places[:places] if places.present?
    items[0..1].map { |place| PlacesPoro.new(place) } if places
  end
end
