import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "summary", "tab"];

  connect() {
    this.showContent();
  }

  showContent() {
    this.contentTarget.classList.remove('hidden');
    this.summaryTarget.classList.add('hidden');
    this.setActiveTab(this.tabTargets[0]);
  }

  showSummary() {
    this.summaryTarget.classList.remove('hidden');
    this.contentTarget.classList.add('hidden');
    this.setActiveTab(this.tabTargets[1]);
  }

  setActiveTab(activeTab) {
    this.tabTargets.forEach(tab => tab.classList.remove('active'));
    activeTab.classList.add('active');
  }
}
