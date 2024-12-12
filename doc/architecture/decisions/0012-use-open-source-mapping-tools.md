# 12. Use open source mapping tools

Date: 2024-09-25

## Status

Accepted

## Context

Representing air pollution and other environment characteristics visually on a
map is an important part of the UX in airTEXT. The [original airTEXT
implementation][] and the [sister project for York][] both used Google Maps.

However, using this commercial product with its fundamental data privacy
uncertainties is not necessary and should be challenged.

## Decision

We believe that excellent mapping and geospatial services can be built using
open source tools. These include:

- [Leaflet][]: a javascript library for presenting maps in HTML
- [OpenStreetMap][]: a public domain map, the base information

We will develop the service using these open source tools in the belief that:

- any usage fees will lower and more transparent
- tracking will be minimised and our users' personal information will be safer

## Consequences

If we are unable to deliver the user benefits which are required, together with
a top-quality user-experience, then we will review this approach.

[original airTEXT implementation]: https://www.airtext.info/
[sister project for York]: https://airqualityalerts.york.gov.uk/maps.php
[Leaflet]: https://leafletjs.com
[OpenStreetMap]: https://www.openstreetmap.org/about
