# frozen_string_literal: true

module ApplicationHelper
  def places_script_tag
    key = ENV.fetch('GOOGLE_MAPS_KEY', nil)
    tag.script(nil,
               src: "https://maps.googleapis.com/maps/api/js?key=#{key}&libraries=places&callback=initAutocomplete",
               defer: true,
               data: { turbo: false })
  end

  def maps_script_tag
    key = ENV.fetch('GOOGLE_MAPS_KEY', nil)
    tag.script(nil,
               src: "https://maps.googleapis.com/maps/api/js?key=#{key}&v=weekly&callback=initMap",
               defer: true,
               data: { turbo: false })
  end
end
