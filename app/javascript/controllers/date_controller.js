import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["start", "end"];

  updateEndDate() {
    const formattedDate = this.startTarget.value;

    this.endTarget.min = formattedDate;

    if (new Date(this.endTarget.value) < new Date(formattedDate)) {
      this.endTarget.value = formattedDate;
    }
  }
}
