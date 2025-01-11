import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { lat: Number, lon: Number, items: Object }

  connect() {
    if (typeof google !== "undefined") {
      this.map();
    }
  }

  map() {
    const lat = this.latValue;
    const lon = this.lonValue;
    const items = this.itemsValue;
    const element = this.element;

    async function initMap() {
      const position = { lat: lat, lng: lon };

      const { Map } = await google.maps.importLibrary("maps");
      const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

      const map = new Map(element, {
        zoom: 12,
        center: position,
        mapId: "MAP_ID",
      });

      Object.entries(items).forEach(([name, location]) => {
        new AdvancedMarkerElement({
          map: map,
          position: { lat: location.lat, lng: location.lon },
          title: name,
        });
      });
    }

    initMap();
  }
}
