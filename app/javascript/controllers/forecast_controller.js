import { Controller } from "@hotwired/stimulus";

export default class ForecastController extends Controller {
  static targets = ["zoneSelector", "dateSelector", "pollutantSelector"];

  changeZone() {
    this.updateUrl({ zone: this.zoneSelectorTarget.value });
    this.updateForecast();
  }

  changeDay(event) {
    const selectedDate = event.currentTarget.dataset.date;

    this.updateUrl({ date: selectedDate });

    // Update contents of dateSelector
    this.dateSelectorTarget.value = selectedDate;

    this.updateForecast();
  }

  selectPollutant(event) {
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault();
      console.log(event.currentTarget);
      event.currentTarget.click();
    }
  }

  changePollutant() {
    this.updateUrl({
      pollutant: this.pollutantSelectorTarget.querySelector(
        "input[name=pollutant]:checked"
      ).value,
    });
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
