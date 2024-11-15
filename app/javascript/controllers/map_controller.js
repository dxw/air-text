import { Controller } from "@hotwired/stimulus";
import L from "leaflet";
import "@maptiler/leaflet-maptilersdk";
import "@maptiler/geocoding-control/leaflet";
import * as zones from "../zone_boundaries/zone-boundaries";

export default class MapController extends Controller {
  static targets = ["map", "pollutantSelector", "daySelector"];

  layers = {};
  controls = {};
  defaultMapSettings = {
    pollutant: "Total",
    date: new Date().toJSON().slice(0, 10),
    center: [51.510357, -0.116773], // Big Ben, lat lng
    zoom: 8,
    maptilerApiKey: document
      .getElementById("map")
      .getAttribute("data-maptiler-api-key"),
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

    this.addSearchControl();

    this.map.createPane("street-map");
    this.addStreetMapLayer();

    this.map.createPane("pollution");
    this.map.getPane("pollution").style.opacity = 0.6;
    this.addPollutionLayer();

    this.map.createPane("zones");
    this.addZonesLayer();
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

  addSearchControl() {
    L.control
      .maptilerGeocoding({
        apiKey: this.settings.maptilerApiKey,
        country: ["GB"],
        proximity: [-0.116773, 51.510357], // Big Ben, lng lat
        types: [
          "region",
          "subregion",
          "county",
          "joint_municipality",
          "joint_submunicipality",
          "municipality",
          "municipal_district",
          "locality",
          "neighbourhood",
          "place",
          "postal_code",
          "address",
          "road",
          "poi",
        ],
      })
      .addTo(this.map);
  }

  streetMaps() {
    const tonerLite = new L.MaptilerLayer({
      apiKey: this.settings.maptilerApiKey,
      style: "toner-v2-lite",
      pane: "street-map",
    });

    const basicLight = new L.MaptilerLayer({
      apiKey: this.settings.maptilerApiKey,
      style: "basic-v2-light",
      pane: "street-map",
    });

    const streetsPastel = new L.MaptilerLayer({
      apiKey: this.settings.maptilerApiKey,
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
    this.layers.pollution = discreteAir;
    this.map.addLayer(this.layers.pollution);

    const pollutionMaps = {
      DiscreteColours: discreteAir,
      LinearColours: linearAir,
    };
    this.controls.pollution = L.control
      .layers(pollutionMaps, null, { collapsed: false })
      .addTo(this.map);
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

  addZonesLayer() {
    const { zoneBoundaryLayers, zoneLabelMarkers } = this.zones();
    zoneBoundaryLayers.forEach((layer) => layer.addTo(this.map));
    this.addZoneLabelMarkers(zoneLabelMarkers);
  }

  zones() {
    const zoneBoundaryLayers = [];
    const zoneLabelMarkers = [];
    const zoneBoundaryLayerLevelStyles = {
      1: { weight: 3 }, // stroke width
      2: { weight: 1 },
    };

    for (const [, zone] of Object.entries(zones)) {
      const layer = L.geoJSON(zone, {
        style: function (feature) {
          return {
            color: "black", // stroke color
            weight:
              zoneBoundaryLayerLevelStyles[feature.properties.level].weight,
            fill: false,
          };
        },
        pane: "zones",
      });

      zoneBoundaryLayers.push(layer);

      const bounds = layer.getBounds();
      const center = bounds.getCenter();

      const label = L.marker(center, {
        icon: L.divIcon({
          className:
            "zone-label " + `zone-label-level-${zone.properties.level}`,
          html: zone.properties.name,
        }),
      });

      zoneLabelMarkers.push({
        marker: label,
        londonBorough: zone.properties.londonBorough,
      });
    }

    return { zoneBoundaryLayers, zoneLabelMarkers };
  }

  addZoneLabelMarkers(zoneLabelMarkers) {
    // Only show the zone labels when the map is zoomed in enough
    zoneLabelMarkers.forEach(({ marker, londonBorough }) => {
      const startZoom = 9 + (londonBorough ? 2 : 0); // Only show London borough labels at higher zoom
      const endZoom = 20;

      // Add the marker to the map initially if within the zoom range
      if (this.map.getZoom() >= startZoom && this.map.getZoom() <= endZoom) {
        marker.addTo(this.map);
      }

      // Attach the zoomend event to control visibility
      this.map.on("zoomend", () => {
        const currentZoom = this.map.getZoom();
        if (currentZoom >= startZoom && currentZoom <= endZoom) {
          this.map.addLayer(marker);
        } else {
          this.map.removeLayer(marker);
        }
      });
    });
  }

  updateMap() {
    const pollutant = this.pollutantSelectorTarget.value;
    const date = this.daySelector.dataset.date;
    const newSettings = { pollutant: pollutant, date: date };
    this.settings = Object.assign({}, this.defaultMapSettings, newSettings);

    this.updatePollutionLayer();
  }

  updatePollutionLayer() {
    this.map.removeControl(this.controls.pollution);
    this.map.removeLayer(this.layers.pollution);
    this.addPollutionLayer();
  }
}
