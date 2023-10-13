import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["photo", 'hello'];

  connect() {
    this.currentIndex = 0;
    this.showCurrentPhoto();
  }

  nextSlide() {
    this.currentIndex += 1;
    if (this.currentIndex >= this.photoTargets.length) {
      this.currentIndex = 0;
    }
    this.showCurrentPhoto();
  }

  prevSlide() {
    this.currentIndex -= 1;
    if (this.currentIndex < 0) {
      this.currentIndex = this.photoTargets.length - 1;
    }
    this.showCurrentPhoto();
  }

  showCurrentPhoto() {
    this.photoTargets.forEach((photo, index) => {
      if (index === this.currentIndex) {
        photo.classList.add("active");
      } else {
        photo.classList.remove("active");
      }
    });
  }
}
