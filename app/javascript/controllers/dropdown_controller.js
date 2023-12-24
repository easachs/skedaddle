import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"];

  toggle() {
    if (this.contentTarget.classList.contains("hidden")) {
      this.contentTarget.classList.remove("hidden");
    }
    else {
      this.contentTarget.classList.add("hidden");
    }
  }
}
