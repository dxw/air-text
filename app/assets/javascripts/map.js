document.addEventListener("turbolinks:load", function () {
  console.log("Turbolinks loaded map.js file");
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    console.log("map placeholder element found. Will draw map...");
    const map = L.map("map").setView([51.505, -0.09], 13);

    L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
      maxZoom: 19,
      attribution:
        '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    }).addTo(map);
  }
});
