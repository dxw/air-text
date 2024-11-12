import L from "leaflet";
import "@maptiler/leaflet-maptilersdk";

document.addEventListener("turbo:load", function () {
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    const bigBenLatLng = [51.510357, -0.116773];

    const airTextBaseUrl = "https://airtext.info/geoserver/wms?";
    const todaysDate = new Date().toJSON().slice(0, 10);
    const maptilerApiKey = mapEle.getAttribute("data-maptiler-api-key");

    const map = L.map("map", {
      center: bigBenLatLng,
      zoom: 8,
    });

    map.createPane("osm"); // OS map
    map.getPane("osm").style.zIndex = 999;
    map.getPane("osm").style.opacity = 0.6;

    // Base maps

    const airTextOptions = {
      layers: "london:Total",
      time: todaysDate,
      format: "image/png",
      opacity: 1,
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

    // Overlay maps

    const tonerLite = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "toner-v2-lite",
      pane: "osm",
    });

    const basicLight = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "basic-v2-light",
      pane: "osm",
    });

    const streetsPastel = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "streets-v2-pastel",
      pane: "osm",
    });

    // Set up default map layers
    map.addLayer(discreteAir);
    map.addLayer(basicLight);

    // Add other layers as options
    const baseMaps = {
      "Discrete Colours": discreteAir,
      "Linear Colours": linearAir,
    };
    L.control.layers(baseMaps, null, { collapsed: false }).addTo(map);

    const overlayMaps = {
      "Toner Lite": tonerLite,
      "Basic Light": basicLight,
      "Streets Pastel": streetsPastel,
    };
    L.control.layers(overlayMaps, null, { collapsed: false }).addTo(map);
  }
});
