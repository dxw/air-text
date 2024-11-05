import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tab"
export default class extends Controller {
  static classes = ["active", "inactive"];
  static targets = ["dayPrediction", "day", "daqiValue"];

  connect() {}

  switch_tab() {
    this.makeAllTabsInactive();
    this.removeDaqiAlertClasses();

    this.addAlertClassIfNotTodayAndHasAirQualityAlert();
    this.dayPredictionTarget.classList.toggle(this.activeClass);
    this.dayPredictionTarget.classList.toggle(this.inactiveClass);
  }

  makeAllTabsInactive() {
    document.querySelectorAll(".tabs .tab").forEach((el) => {
      el.classList.remove(this.activeClass);
      el.classList.add(this.inactiveClass);
    });
  }

  addAlertClassIfNotTodayAndHasAirQualityAlert() {
    const daqiValue = this.getDaqiValue();
    if (this.dayTarget.innerText !== "Today" && daqiValue > 3) {
      this.addDaqiAlertClass();
    }
  }

  addDaqiAlertClass() {
    const daqiValue = this.getDaqiValue();
    this.dayPredictionTarget.classList.add(
      `daqi-alert-after-today-selected-level-${daqiValue}`
    );
  }

  removeDaqiAlertClasses() {
    document.querySelectorAll(".tabs .tab").forEach((el) => {
      const daqiAlertClassRegex = new RegExp(
        "daqi-alert-after-today-selected-level-(\\d{1,2})"
      );

      const fullClassName = Array.from(el.classList).find((className) =>
        className.match(daqiAlertClassRegex)
      );

      if (fullClassName) {
        el.classList.remove(fullClassName);
      }
    });
  }

  getDaqiValue() {
    return this.daqiValueTarget.innerText.split("/")[0].split(" ")[1];
  }
}
