import L from "leaflet";
import "@maptiler/leaflet-maptilersdk";

document.addEventListener("turbo:load", function () {
  const mapEle = document.querySelector("#map");

  if (mapEle) {
    console.log("map is on the page");

    const bigBenLatLng = [51.510357, -0.116773];

    const airTextBaseUrl = "https://airtext.info/geoserver/wms?";
    const todaysDate = new Date().toJSON().slice(0, 10);
    const maptilerApiKey = mapEle.getAttribute("data-maptiler-api-key");

    const airTextOptions = {
      layers: "london:Total",
      time: todaysDate,
      format: "image/png",
      opacity: 0.6,
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

    const mtLayer = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "positron",
      transparent: false,
    });

    const overlayMaps = {
      Discrete: discreteAir,
      Linear: linearAir,
    };
    const baseMaps = {
      MapTiler: mtLayer,
    };

    const map = L.map("map", {
      center: bigBenLatLng,
      zoom: 8,
      layers: [discreteAir],
    });
    map.addLayer(mtLayer);

    L.control.layers(overlayMaps, baseMaps, { collapsed: false }).addTo(map);
  }
});
