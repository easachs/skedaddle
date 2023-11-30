import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["content"];

  connect() {
    this.contentTarget.classList.add("hidden");
  }

  toggle() {
    if (this.contentTarget.classList.contains("hidden")) {
      this.contentTarget.classList.remove("hidden");
    }
    else {
      this.contentTarget.classList.add("hidden");
    }
  }
}
