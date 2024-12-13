import { Controller } from "@hotwired/stimulus";

export default class ApplicationController extends Controller {
  connect() {
    document.addEventListener("turbo:load", () => {
      this.addShowButtonToSummaryTags();
    });
    document.addEventListener("turbo:frame-load", () => {
      this.addShowButtonToSummaryTags();
    });
  }

  addShowButtonToSummaryTags() {
    this.element.querySelectorAll("summary").forEach((summary) => {
      const button = document.createElement("button");
      button.className = "show-button";
      button.onclick = (e) => {
        e.preventDefault();
        summary.parentElement.open = !summary.parentElement.open;
      };
      summary.appendChild(button);
    });
  }
}
