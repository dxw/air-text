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
        const button = document.createElement("button");
        button.innerHTML = "Show";
        button.className = "show-button";
        button.tabIndex = -1;
        button.onclick = (e) => {
          e.preventDefault();
          summary.parentElement.open = !summary.parentElement.open;
          button.innerHTML = summary.parentElement.open ? "Hide" : "Show";
        };
        summary.appendChild(button);
      }
    });
  }

  scrollToTop() {
    window.scrollTo({ top: 0 });
  }
}
