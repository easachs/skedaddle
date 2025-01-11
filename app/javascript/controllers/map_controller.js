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
        keyboardShortcuts: false,
        streetViewControl: false
      });

      const infoWindow = new google.maps.InfoWindow();

      Object.entries(items).forEach(([name, details]) => {

        // const mapTag = document.createElement("div");
        // mapTag.className = "map-tag";
        // mapTag.textContent = name;

        const marker = new AdvancedMarkerElement({
          map: map,
          position: { lat: details.lat, lng: details.lon },
          title: name//,
          // content: mapTag
        });

        const content = `
          <div class="info-window">
            <strong>${name}</strong>
            <p>${details.location}</p>
          </div>
        `;

        marker.addListener("click", () => {
          infoWindow.close();
          infoWindow.setContent(content);
          infoWindow.open(map, marker);
        });
      });
    }

    initMap();
  }
}
