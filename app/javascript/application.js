import "@hotwired/turbo-rails"
import "controllers"

window.initAutocomplete = function () {
  const event = new Event('autocomplete-callback');
  window.dispatchEvent(event);
}

window.initMap = function() {
  const event = new Event('map-callback');
  window.dispatchEvent(event);
}
