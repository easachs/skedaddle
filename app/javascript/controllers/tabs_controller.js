import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["places", "info", "map", "plan", "tab"];

  showPlaces() {
    this.toggleVisibility(this.placesTarget);
    this.setActiveTab(this.tabTargets[0]);
  }

  showInfo() {
    this.toggleVisibility(this.infoTarget);
    this.setActiveTab(this.tabTargets[1]);
  }

  showMap() {
    this.toggleVisibility(this.mapTarget);
    this.setActiveTab(this.tabTargets[2]);
  }

  showPlan() {
    this.toggleVisibility(this.planTarget);
    this.setActiveTab(this.tabTargets[3]);
  }

  toggleVisibility(visibleTarget) {
    [this.placesTarget, this.infoTarget, this.mapTarget, this.planTarget].forEach(target => target.classList.add('hidden'));
    visibleTarget.classList.remove('hidden');
  }

  setActiveTab(activeTab) {
    this.tabTargets.forEach(tab => tab.classList.remove('active'));
    activeTab.classList.add('active');
  }
}
