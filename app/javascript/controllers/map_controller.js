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

  mapTargetConnected() {
    this.updateSettings();
    this.createMap();
  }

  updateSettings() {
    const pollutant = this.pollutantSelectorTarget.value;
    const date = this.daySelectorTarget.querySelector(".active").dataset.date;
    const newSettings = { pollutant: pollutant, date: date };
    this.settings = Object.assign({}, this.defaultMapSettings, newSettings);
  }

  createMap() {
    this.map = L.map("map", {
      center: this.settings.center,
      zoom: this.settings.zoom,
    });

    this.addSearchControl();

    // Ordered from bottom to top
    this.map.createPane("street-map");
    this.addStreetMapLayer();

    this.map.createPane("pollution");
    this.map.getPane("pollution").style.opacity = 0.6;
    this.addPollutionLayer();

    this.map.createPane("place-names");
    this.addPlaceNamesLayer();

    this.map.createPane("zones");
    this.addZonesLayer();
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

  addStreetMapLayer() {
    const streetMap = new L.MaptilerLayer({
      apiKey: this.settings.maptilerApiKey,
      style: "13be04a7-d035-45cd-b5cf-6c0c50fdf6a8",
      pane: "street-map",
    });
    this.map.addLayer(streetMap);
  }

  addPlaceNamesLayer() {
    const placeNames = new L.MaptilerLayer({
      apiKey: this.settings.maptilerApiKey,
      style: "1cc6214b-0f45-4e3d-a5bc-8e81b82cca7a",
      pane: "place-names",
    });
    this.map.addLayer(placeNames);
  }

  addPollutionLayer() {
    this.layers.pollution = this.pollutionLayer(
      this.settings.pollutant,
      this.settings.date
    );
    this.map.addLayer(this.layers.pollution);
  }

  pollutionLayer(pollutant, date) {
    return L.tileLayer.wms("https://airtext.info/geoserver/wms?", {
      layers: `london:${pollutant}`,
      time: date,
      format: "image/png",
      opacity: 1,
      pane: "pollution",
      styles: `daqi${pollutant}_linear`,
    });
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
    this.updateSettings();
    this.updatePollutionLayer();
  }

  updatePollutionLayer() {
    this.map.removeLayer(this.layers.pollution);
    this.addPollutionLayer();
  }
}
