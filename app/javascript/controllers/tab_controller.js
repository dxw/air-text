import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tab"
export default class TabController extends Controller {
  static targets = ["daySelector"];

  connect() {}

  changeTab(event) {
    const selectedDay = event.currentTarget.dataset.day;

    // Add the new date to the URL
    const url = new URL(window.location.href);
    url.searchParams.set("day", selectedDay);
    window.history.pushState({}, "", url);

    // Update contents of daySelector
    this.daySelectorTarget.value = selectedDay;

    // Submit the form to reload the turbo frame
    this.daySelectorTarget.form.requestSubmit();
  }
}
