import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"];

  toggle() {
    this.itemTarget.classList.toggle("hidden");
  }
}
