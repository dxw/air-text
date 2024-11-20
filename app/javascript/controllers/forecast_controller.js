import { Controller } from "@hotwired/stimulus";

export default class ForecastController extends Controller {
  static targets = ["zoneSelector", "daySelector"];

  changeZone() {
    this.updateUrl({ zone: this.zoneSelectorTarget.value });
    this.reloadPrediction();
  }

  changeDay(event) {
    const selectedDay = event.currentTarget.dataset.day;

    this.updateUrl({ day: selectedDay });

    // Update contents of daySelector
    this.daySelectorTarget.value = selectedDay;

    this.reloadPrediction();
  }

  reloadPrediction() {
    // Submit the form to reload the turbo frame
    this.zoneSelectorTarget.form.requestSubmit();
  }

  updateUrl(newParams) {
    const url = new URL(window.location.href);
    for (const [key, value] of Object.entries(newParams)) {
      url.searchParams.set(key, value);
    }
    window.history.pushState({}, "", url);
  }
}
