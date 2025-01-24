import { Controller } from "@hotwired/stimulus";

export default class ApplicationController extends Controller {
  connect() {
    ["turbo:load", "turbo:frame-load", "turbo:render"].forEach((eventName) => {
      document.addEventListener(eventName, () => {
        this.addShowButtonToSummaryTags();
      });
    });
  }

  addShowButtonToSummaryTags() {
    this.element.querySelectorAll("summary").forEach((summary) => {
      if (!summary.querySelector(".show-button")) {
        const button = document.createElement("span");
        button.title = "Show more";
        button.className = "show-button";
        button.tabIndex = -1;
        summary.appendChild(button);
      }
    });
  }

  scrollToTop() {
    window.scrollTo({ top: 0 });
  }
}
