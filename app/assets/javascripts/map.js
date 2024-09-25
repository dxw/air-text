document.addEventListener("turbolinks:load", function () {
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    const bigBenLatLng = [51.510357, -0.116773];
    const map = L.map("map").setView(bigBenLatLng, 10);

    const cercOptions = {
      layers: "london:Total",
      time: "2024-09-25",
      format: "image/png",
      transparency: true, // term used by CERC
      styles: "daqiTotal",
      // styles: "daqiTotal_linear"
      //   we heard: "This can provide a more detailed map, at the expense of
      //   less clearly defined bands."
    };
    const osmOptions = {
      layers: "OSM-Overlay-WMS",
      format: "image/png",
      transparent: true, // standard term (?) used by Leaflet and OSM
    };

    // compose the map using our WMS layers
    L.tileLayer
      .wms("https://airtext.info/geoserver/wms?", cercOptions)
      .addTo(map);
    L.tileLayer
      .wms("https://ows.mundialis.de/services/service?", osmOptions)
      .addTo(map);
  }
});
