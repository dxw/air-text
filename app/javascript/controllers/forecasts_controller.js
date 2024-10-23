import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="forecasts"
export default class extends Controller {
  connect() {
    console.log("connected Stimulus!")
  }
}
