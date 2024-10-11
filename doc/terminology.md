# Terminology

## Purpose

We aim to use and refine a "ubiquitous language" for use throughout the service.
We believe that this will optimise our communication and minimise our
misunderstandings and our cognitive load. We will aim use the same terms in:

- the UI of the service
- the code we write
- our sketches and mockups
- our research sessions
- our documentation and our presentations to partner organisations

## Terms

We are provided with daily **`forecasts`** by CERC. Each forecast consists of 6
environmental **`predictions`**:

- Air pollution
- UV
- Pollen
- Temperature
- Wind
- Rain

Each **prediction** has an **`DAQI level`**. This [DAQI (Daily Air
Quality Index)][] scoring uses the range 1-10:

- low (1-3)
- moderate (4-6)
- high (7-9)
- very high (10)

An **`alert`** is in effect when a particular prediction's DAQI level is above a
certain threshold e.g. tomorrow the:

- UV prediction has the **moderate** DAQI level
- pollen prediction has the **low** DAQI level
- air pollution prediction has the **high** DAQI level (aka an "**Air quality
  alert**: high")

**Air quality alerts** are air pollution predictions with DAQI leveles above
"low".

[DAQI (Daily Air Quality Index)]: https://uk-air.defra.gov.uk/air-pollution/daqi
