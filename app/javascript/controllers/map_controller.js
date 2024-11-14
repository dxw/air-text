import { Controller } from "@hotwired/stimulus";
import L from "leaflet";
import "@maptiler/leaflet-maptilersdk";

export default class MapController extends Controller {
  defaultMapSettings = {
    pollutant: "Total",
    date: new Date().toJSON().slice(0, 10),
    center: [51.510357, -0.116773], // Big Ben
    zoom: 8,
  };

  connect() {
    this.settings = this.defaultMapSettings;
    this.createMap();
  }

  createMap() {
    this.map = L.map("map", {
      center: this.settings.center,
      zoom: this.settings.zoom,
    });

    this.map.createPane("street-map");
    this.addStreetMapLayer();

    this.map.createPane("pollution");
    this.map.getPane("pollution").style.opacity = 0.6;
    this.addPollutionLayer();
  }

  addStreetMapLayer() {
    const { tonerLite, basicLight, streetsPastel } = this.streetMaps();
    this.map.addLayer(basicLight);

    const streetMaps = {
      TonerLite: tonerLite,
      BasicLight: basicLight,
      StreetsPastel: streetsPastel,
    };
    L.control.layers(streetMaps, null, { collapsed: false }).addTo(this.map);
  }

  streetMaps() {
    const maptilerApiKey = document
      .getElementById("map")
      .getAttribute("data-maptiler-api-key");
    const tonerLite = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "toner-v2-lite",
      pane: "street-map",
    });

    const basicLight = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "basic-v2-light",
      pane: "street-map",
    });

    const streetsPastel = new L.MaptilerLayer({
      apiKey: maptilerApiKey,
      style: "streets-v2-pastel",
      pane: "street-map",
    });

    return { tonerLite, basicLight, streetsPastel };
  }

  addPollutionLayer() {
    const { discreteAir, linearAir } = this.pollutionLayers(
      this.settings.pollutant,
      this.settings.date
    );
    this.map.addLayer(discreteAir);

    const pollutionMaps = {
      DiscreteColours: discreteAir,
      LinearColours: linearAir,
    };
    L.control.layers(pollutionMaps, null, { collapsed: false }).addTo(this.map);
  }

  pollutionLayers(pollutant, date) {
    const airTextBaseUrl = "https://airtext.info/geoserver/wms?";
    const airTextOptions = {
      layers: `london:${pollutant}`,
      time: date,
      format: "image/png",
      opacity: 1,
      pane: "pollution",
    };

    const mergeAirTextOptions = (options) => {
      return Object.assign({}, airTextOptions, options);
    };

    const discreteAir = L.tileLayer.wms(
      airTextBaseUrl,
      mergeAirTextOptions({ styles: `daqi${pollutant}` })
    );

    const linearAir = L.tileLayer.wms(
      airTextBaseUrl,
      mergeAirTextOptions({ styles: `daqi${pollutant}_linear` })
    );

    return { discreteAir, linearAir };
  }
}
