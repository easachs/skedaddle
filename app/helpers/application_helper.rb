# frozen_string_literal: true

module ApplicationHelper
  def places_script_tag
    key = ENV.fetch('GOOGLE_MAPS_KEY', nil)
    tag.script(nil,
               src: "https://maps.googleapis.com/maps/api/js?key=#{key}&libraries=places&callback=initMap",
               defer: true,
               data: { turbo: false })
  end
end
