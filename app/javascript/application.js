// Entry point for the build script in your package.json
import * as Turbo from "@hotwired/turbo";

import TurboPower from "turbo_power";
TurboPower.initialize(Turbo.StreamActions);

document.addEventListener("DOMContentLoaded", function () {
  const hamburgerMenu = document.getElementById("hamburger-menu");
  const menuList = document.getElementById("menu-list");

  hamburgerMenu.addEventListener("click", function () {
    menuList.classList.toggle("hidden");
  });

  const locationButton = document.getElementById("location-selector-button");
  const locationList = document.getElementById("location-selector-list");

  locationButton &&
    locationButton.addEventListener("click", function () {
      locationList.classList.toggle("hidden");
    });

  locationList &&
    locationList.addEventListener("click", function (e) {
      const selectedZone = e.target.innerText;
      const selectedZoneInput = document.getElementById("zone");
      selectedZoneInput.value = selectedZone;
      const selectedZoneLabel = document.getElementById("selected-zone-label");
      selectedZoneLabel.innerText = selectedZone;
      locationList.classList.toggle("hidden");
    });
});
import "./controllers";
