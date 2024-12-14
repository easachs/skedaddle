import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output"];

  update() {
    this.outputTargets.forEach((outputTarget) => {
      outputTarget.textContent = `${this.inputTarget.value} km`;
    });
  }
}
