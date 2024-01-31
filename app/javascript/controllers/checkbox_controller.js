import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "checkbox"]

  toggle() {
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.checked = this.sourceTarget.checked;
    });
  }
}
