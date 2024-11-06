import L from "leaflet";
import "@maptiler/leaflet-maptilersdk";

document.addEventListener("turbo:load", function () {
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    const bigBenLatLng = [51.510357, -0.116773];

    const airTextBaseUrl = "https://airtext.info/geoserver/wms?";
    const todaysDate = new Date().toJSON().slice(0, 10);
    const maptilerApiKey = mapEle.getAttribute("data-maptiler-api-key");

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

    const map = L.map("map", {
      center: bigBenLatLng,
      zoom: 8,
      layers: [discreteAir],
    });

    map.createPane("osm");
    map.getPane("osm").style.zIndex = 999;
    map.getPane("osm").style.opacity = 0.6;

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

    map.addLayer(basicLight);

    const baseMaps = {
      DiscreteColours: discreteAir,
      LinearColours: linearAir,
    };
    const overlayMaps = {
      TonerLite: tonerLite,
      BasicLight: basicLight,
      StreetsPastel: streetsPastel,
    };

    L.control.layers(baseMaps, null, { collapsed: false }).addTo(map);
    L.control.layers(overlayMaps, null, { collapsed: false }).addTo(map);
  }
});
