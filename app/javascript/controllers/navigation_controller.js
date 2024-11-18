import { Controller } from "@hotwired/stimulus";

export default class NavigationController extends Controller {
  static targets = ["menuList"];

  toggleMenu() {
    this.menuListTarget.classList.toggle("hidden");
  }
}
