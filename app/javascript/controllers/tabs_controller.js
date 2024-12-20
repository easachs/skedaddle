import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["info", "map", "gpt", "tab"];

  showInfo() {
    this.toggleVisibility(this.infoTarget);
    this.setActiveTab(this.tabTargets[0]);
  }

  showMap() {
    this.toggleVisibility(this.mapTarget);
    this.setActiveTab(this.tabTargets[1]);
  }

  showGpt() {
    this.toggleVisibility(this.gptTarget);
    this.setActiveTab(this.tabTargets[2]);
  }

  toggleVisibility(visibleTarget) {
    [this.infoTarget, this.gptTarget, this.mapTarget].forEach(target => target.classList.add('hidden'));
    visibleTarget.classList.remove('hidden');
  }

  setActiveTab(activeTab) {
    this.tabTargets.forEach(tab => tab.classList.remove('active'));
    activeTab.classList.add('active');
  }
}
