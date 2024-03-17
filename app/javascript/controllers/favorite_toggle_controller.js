import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["heart"];

  connect() {
    console.log("hello from favorite toggle controller");
  }

  fire() {
    console.log(this.heartTarget);
    this.heartTarget.classList.toggle("fa-regular");
    this.heartTarget.classList.toggle("fa-solid");
  }
}
