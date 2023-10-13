import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["photo"];

  connect() {
    this.currentIndex = 0;
    this.showCurrentPhoto();

    // this.intervalId = setInterval(() => {
    //   this.nextSlide();
    // }, 5000);
  }

  // disconnect() {
  //   clearInterval(this.intervalId);
  // }

  nextSlide() {
    this.currentIndex += 1;
    if (this.currentIndex > 5) {
      this.currentIndex = 0;
    }
    this.showCurrentPhoto();
  }

  // prevSlide() {
  //   this.currentIndex -= 1;
  //   if (this.currentIndex < 0) {
  //     this.currentIndex = 5;
  //   }
  //   this.showCurrentPhoto();
  // }

  showCurrentPhoto() {
    this.photoTargets.forEach((photo, index) => {
      if (index === this.currentIndex) {
        photo.classList.remove("hidden");
      } else {
        photo.classList.add("hidden");
      }
    });
  }
}
