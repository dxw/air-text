# Terminology

CERC provides daily **forecasts** for each **zone**. Each forecast consists of 6
environmental **predictions**:

- Air pollution (NO2, PM10, PM2.5, O3, and total), rated on a scale of 1-10
- UV, rated on a scale of 1-10
- Pollen, rated on a scale of 1-10
- Temperature, in degrees Celsius
- Wind, in mph
- Rain, in mm

We don't use rain or wind predictions in the service.

Several of the numeric predictions are then converted into **labels** of low,
moderate, high, or very high. This is explained on the health advice page, and
is based on the [DAQI (Daily Air Quality Index)].

There is an air quality **alert** when the air pollution prediction for a zone
is moderate or higher.

[DAQI (Daily Air Quality Index)]: https://uk-air.defra.gov.uk/air-pollution/daqi
