import { Controller } from "@hotwired/stimulus";

export default class NavigationController extends Controller {
  static targets = ["menuButton", "menuList"];

  toggleMenu() {
    this.menuListTarget.classList.toggle("menu-open");
    this.menuButtonTarget.classList.toggle("menu-open");
  }
}
