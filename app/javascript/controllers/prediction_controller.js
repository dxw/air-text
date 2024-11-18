import { Controller } from "@hotwired/stimulus";

export default class PredictionController extends Controller {
  static targets = ["showButton", "hideButton", "guidance", "zoneSelector"];

  toggleGuidance() {
    this.showButtonTarget.classList.toggle("hidden");
    this.hideButtonTarget.classList.toggle("hidden");
    this.guidanceTarget.classList.toggle("hidden");
  }

  changeZone() {
    const selectedZone = this.zoneSelectorTarget.value;

    // Update the URL with the new zone
    const url = new URL(window.location.href);
    url.searchParams.set("zone", selectedZone);
    window.history.pushState({}, "", url);

    // Submit the form to reload the turbo frame
    this.zoneSelectorTarget.form.requestSubmit();
  }
}
