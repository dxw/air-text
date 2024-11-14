# Zone boundaries

Zone boundaries are shown on the map. They have been provided by CERC and are
defined in geojson files.

Each file has the following structure:

```
{
  "type": "Feature",
  "properties": {
    "name": "Cambridge",
    "level": 1,
    "londonBorough": false
  },
  "geometry": {
    "type": "Polygon",
    "coordinates": [
      [
        [
          0.099278948871109,
          52.17130208304546
        ],
        [
          0.101550134128387,
          52.17483952151806
        ],
        ...
      ]
    ]
  }
}
```

"Level" is 1 for top level zones like Central London, and 2 for smaller zones
like . They are rendered slightly differently on the map. "londonBorough" is
true for London boroughs and false otherwise. It controls when the zone label
will appear.

When the polygon defined by the coordinates is overly detailed, you can run
`script/simplify-geojson`, which will generated simplified versions of all the
boundaries with smaller file sizes.
