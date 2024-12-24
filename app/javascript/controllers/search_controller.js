import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['field', 'button'];

  connect() {
    this.toggleButton();
  }

  toggleButton() {
    const isFieldEmpty = this.fieldTarget.value.trim() === '';
    this.buttonTarget.disabled = isFieldEmpty;
  }

  onFieldChange() {
    this.toggleButton();
  }
}
