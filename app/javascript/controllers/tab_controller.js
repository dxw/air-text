import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tab"
export default class extends Controller {
  static classes = ["active"];
  static targets = ["day"];

  connect() {}

  switch_tab() {
    this.makeAllTabsInactive();
    this.dayTarget.classList.toggle(this.activeClass);
  }

  makeAllTabsInactive() {
    document
      .querySelectorAll(".tabs .tab")
      .forEach((el) => el.classList.remove(this.activeClass));
  }
}
