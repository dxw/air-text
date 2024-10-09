// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";

document.addEventListener("turbo:load", function () {
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    console.log("map is on the page");
  }
});
import "@hotwired/turbo-rails";
