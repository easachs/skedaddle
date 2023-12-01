import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["error"];

  connect() {
    setTimeout(() => {
      this.errorTarget.classList.add("hidden");
    }, 3000);
  }
}
