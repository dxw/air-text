// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";

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
      const newSelectedZone = e.target.innerText;
      const selectedZone = document.getElementById("selected-zone");
      selectedZone.innerText = newSelectedZone;
      locationList.classList.toggle("hidden");
    });

  const pollutantSelectorButton = document.getElementById(
    "pollutant-selector-button"
  );
  const pollutantMenu = document.getElementById("pollutant-selector-menu");

  pollutantSelectorButton &&
    pollutantSelectorButton.addEventListener("click", function () {
      pollutantMenu.classList.toggle("hidden");
    });

  pollutantMenu &&
    pollutantMenu.addEventListener("click", function (e) {
      const newSelectedPollutant = e.target.innerText;
      const selectedPollutant = document.getElementById("selected-pollutant");
      selectedPollutant.innerText = newSelectedPollutant;
      pollutantMenu.classList.toggle("hidden");
    });
});
import "./controllers";
