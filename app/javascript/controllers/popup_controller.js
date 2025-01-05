import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['trigger'];
  static values = { delay: Number };

  connect() {
    setTimeout(() => {
      this.triggerTarget.click();
    }, this.delayValue || 20000);
  }
}
