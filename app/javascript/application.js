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
});
