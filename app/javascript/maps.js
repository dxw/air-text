import L from "leaflet";
import "@maptiler/leaflet-maptilersdk";
import * as zones from "./zone_boundaries/zone-boundaries";

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
      });

      zoneBoundaryLayers.push(layer);

      // Get centre of zone
      const bounds = layer.getBounds();
      const center = bounds.getCenter();

      // Add a label at centre
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

    // Only show the zone labels when the map is zoomed in enough
    zoneLabelMarkers.forEach(({ marker, londonBorough }) => {
      const startZoom = 9 + (londonBorough ? 2 : 0); // Only show London borough labels at higher zoom
      const endZoom = 20;

      // Add the marker to the map initially if within the zoom range
      if (map.getZoom() >= startZoom && map.getZoom() <= endZoom) {
        marker.addTo(map);
      }

      // Attach the zoomend event to control visibility
      map.on("zoomend", function () {
        const currentZoom = map.getZoom();
        console.log(currentZoom);
        if (currentZoom >= startZoom && currentZoom <= endZoom) {
          map.addLayer(marker);
        } else {
          map.removeLayer(marker);
        }
      });
    });

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
    zoneBoundaryLayers.forEach((layer) => map.addLayer(layer));

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
