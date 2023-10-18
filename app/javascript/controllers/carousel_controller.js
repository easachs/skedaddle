import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["photo"];
  currentIndex = 0;

  connect() {
    this.showCurrentPhoto();
    this.startInterval();
  }

  disconnect() {
    clearInterval(this.intervalId);
  }

  startInterval() {
    this.intervalId = setInterval(() => {
      this.nextSlide();
    }, 5000);
  }

  nextSlide() {
    this.currentIndex = (this.currentIndex + 1) % this.photoTargets.length;
    this.showCurrentPhoto();
    this.resetInterval();
  }

  showCurrentPhoto() {
    this.photoTargets.forEach((photo, index) => {
      photo.classList.toggle("hidden", index !== this.currentIndex);
    });
  }

  resetInterval() {
    clearInterval(this.intervalId);
    this.startInterval();
  }
}
