import { Controller } from "@hotwired/stimulus";

export default class PredictionController extends Controller {
  static targets = ["showButton", "hideButton", "guidance"];

  toggleGuidance() {
    this.showButtonTarget.classList.toggle("hidden");
    this.hideButtonTarget.classList.toggle("hidden");
    this.guidanceTarget.classList.toggle("hidden");
  }
}
