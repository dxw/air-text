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

  locationButton.addEventListener("click", function () {
    locationList.classList.toggle("hidden");
  });

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

  pollutantSelectorButton.addEventListener("click", function () {
    pollutantMenu.classList.toggle("hidden");
  });

  pollutantMenu.addEventListener("click", function (e) {
    const newSelectedPollutant = e.target.innerText;
    const selectedPollutant = document.getElementById("selected-pollutant");
    selectedPollutant.innerText = newSelectedPollutant;
    pollutantMenu.classList.toggle("hidden");
  });

  const showUvGuidanceButton = document.getElementById(
    "ultraviolet-rays-uv-show-guidance-button"
  );
  const hideUvGuidanceButton = document.getElementById(
    "ultraviolet-rays-uv-hide-guidance-button"
  );
  const uvGuidance = document.getElementById("ultraviolet-rays-uv-guidance");

  [showUvGuidanceButton, hideUvGuidanceButton].forEach((button) => {
    button.addEventListener("click", function () {
      showUvGuidanceButton.classList.toggle("hidden");
      hideUvGuidanceButton.classList.toggle("hidden");
      uvGuidance.classList.toggle("hidden");
    });
  });

  const showPollenGuidanceButton = document.getElementById(
    "pollen-show-guidance-button"
  );
  const hidePollenGuidanceButton = document.getElementById(
    "pollen-hide-guidance-button"
  );
  const pollenGuidance = document.getElementById("pollen-guidance");

  [showPollenGuidanceButton, hidePollenGuidanceButton].forEach((button) => {
    button.addEventListener("click", function () {
      showPollenGuidanceButton.classList.toggle("hidden");
      hidePollenGuidanceButton.classList.toggle("hidden");
      pollenGuidance.classList.toggle("hidden");
    });
  });
});
import "./controllers";
