// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

window.initMap = function () {
  const event = new Event('google-maps-callback');
  window.dispatchEvent(event);
}
