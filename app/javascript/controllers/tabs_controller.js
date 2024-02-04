import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["info", "gpt", "tab"];

  showInfo() {
    this.infoTarget.classList.remove('hidden');
    this.gptTarget.classList.add('hidden');
    this.setActiveTab(this.tabTargets[0]);
  }

  showGpt() {
    this.gptTarget.classList.remove('hidden');
    this.infoTarget.classList.add('hidden');
    this.setActiveTab(this.tabTargets[1]);
  }

  setActiveTab(activeTab) {
    this.tabTargets.forEach(tab => tab.classList.remove('active'));
    activeTab.classList.add('active');
  }
}
