import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["error"];

  connect() {
    if (this.hasErrorTarget) {
      setTimeout(() => {
        this.errorTarget.classList.add("hidden");
      }, 5000);
    }
  }
}
