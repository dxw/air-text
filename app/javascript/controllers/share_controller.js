import { Controller } from "@hotwired/stimulus";

export default class ShareController extends Controller {
  static targets = ["webShareOptions", "shareMessage"];

  openMenu() {
    if (this.isMobileDevice() && navigator.share) {
      this.showNativeShareMenu();
    } else {
      this.showWebShareMenu();
    }
  }

  isMobileDevice() {
    return (
      /iPhone|iPad|iPod|Android/i.test(navigator.userAgent) ||
      /Mobile/i.test(navigator.userAgent) ||
      navigator.userAgentData.mobile
    );
  }

  showNativeShareMenu() {
    navigator.share({
      url: window.location.href,
      text: this.shareMessageTarget.textContent,
      file: [],
    });
  }

  showWebShareMenu() {
    this.webShareOptionsTarget.classList.toggle("hidden");
  }

  copyLink(e) {
    e.preventDefault();
    navigator.clipboard.writeText(window.location.href);
  }
}
