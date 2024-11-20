import { Controller } from "@hotwired/stimulus";

export default class ForecastController extends Controller {
  static targets = ["zoneSelector", "daySelector", "pollutantSelector"];

  changeZone() {
    this.updateUrl({ zone: this.zoneSelectorTarget.value });
    this.updateForecast();
  }

  changeDay(event) {
    const selectedDate = event.currentTarget.dataset.date;

    this.updateUrl({ date: selectedDate });

    // Update contents of daySelector
    this.daySelectorTarget.value = selectedDate;

    this.updateForecast();
  }

  changePollutant() {
    this.updateUrl({ pollutant: this.pollutantSelectorTarget.value });
    this.updateForecast();
  }

  updateForecast() {
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
