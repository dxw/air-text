document.addEventListener("turbolinks:load", function () {
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    const bigBenLatLng = [51.510357, -0.116773];

    const osmBaseUrl = "https://ows.mundialis.de/services/service?";
    const airTextBaseUrl = "https://airtext.info/geoserver/wms?";

    const airTextOptions = {
      layers: "london:Total",
      time: "2024-09-26",
      format: "image/png",
      transparency: true, // term used by CERC
    };

    const mergeAirTextOptions = (options) => {
      return Object.assign({}, airTextOptions, options);
    };

    const discreteAir = L.tileLayer.wms(
      airTextBaseUrl,
      mergeAirTextOptions({ styles: "daqiTotal" })
    );

    const linearAir = L.tileLayer.wms(
      airTextBaseUrl,
      mergeAirTextOptions({ styles: "daqiTotal_linear" })
    );

    const osm = L.tileLayer.wms(osmBaseUrl, {
      layers: "OSM-Overlay-WMS",
      format: "image/png",
      transparent: true, // standard term (?) used by Leaflet and OSM
    });

    const baseMaps = {
      Discrete: discreteAir,
      Linear: linearAir,
    };
    const overlayMaps = {
      OSM: osm,
    };

    const map = L.map("map", {
      center: bigBenLatLng,
      zoom: 10,
      layers: [discreteAir, osm],
    });

    baseMaps.Discrete.addTo(map);
    overlayMaps.OSM.addTo(map);
    L.control.layers(baseMaps, overlayMaps, { collapsed: false }).addTo(map);
  }
});
