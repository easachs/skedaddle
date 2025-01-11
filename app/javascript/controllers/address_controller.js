import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (typeof google !== "undefined") {
      this.autocomplete();
    }
  }
  
  autocomplete() {
    const input = this.element;
    const autocomplete = new google.maps.places.Autocomplete(input,{
      types: ['political'],
      fields: ['formatted_address']
    });

    autocomplete.addListener('place_changed', () => {
      autocomplete.getPlace();
    });
  }

  keydown(event) {
    if (event.key == 'Enter') {
      event.preventDefault();
    }
  }
}
