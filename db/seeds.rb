# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

london = ZoneGroup.create(name: "London", description: "", order: 10)
london_surrounds = ZoneGroup.create(name: "London surrounds", description: "Surrey, Slough, and Thurrock", order: 20)
essex = ZoneGroup.create(name: "Essex", description: "Chelmsford, Maldon, and Colchester", order: 30)
cambridge = ZoneGroup.create(name: "Cambridge", description: "", order: 40)

Zone.create([
  {name: "Barking and Dagenham", zone_group: london, cerc_id: 1, cerc_type: 1},
  {name: "Barnet", zone_group: london, cerc_id: 2, cerc_type: 1},
  {name: "Bexley", zone_group: london, cerc_id: 3, cerc_type: 1},
  {name: "Brent", zone_group: london, cerc_id: 4, cerc_type: 1},
  {name: "Bromley", zone_group: london, cerc_id: 5, cerc_type: 1},
  {name: "Camden", zone_group: london, cerc_id: 6, cerc_type: 1},
  {name: "City of London", zone_group: london, cerc_id: 7, cerc_type: 1},
  {name: "Croydon", zone_group: london, cerc_id: 8, cerc_type: 1},
  {name: "Ealing", zone_group: london, cerc_id: 9, cerc_type: 1},
  {name: "Enfield", zone_group: london, cerc_id: 10, cerc_type: 1},
  {name: "Greenwich", zone_group: london, cerc_id: 11, cerc_type: 1},
  {name: "Hackney", zone_group: london, cerc_id: 12, cerc_type: 1},
  {name: "Hammersmith and Fulham", zone_group: london, cerc_id: 13, cerc_type: 1},
  {name: "Haringey", zone_group: london, cerc_id: 14, cerc_type: 1},
  {name: "Harrow", zone_group: london, cerc_id: 15, cerc_type: 1},
  {name: "Havering", zone_group: london, cerc_id: 16, cerc_type: 1},
  {name: "Hillingdon", zone_group: london, cerc_id: 17, cerc_type: 1},
  {name: "Hounslow", zone_group: london, cerc_id: 18, cerc_type: 1},
  {name: "Islington", zone_group: london, cerc_id: 19, cerc_type: 1},
  {name: "Kensington and Chelsea", zone_group: london, cerc_id: 20, cerc_type: 1},
  {name: "Kingston upon Thames", zone_group: london, cerc_id: 21, cerc_type: 1},
  {name: "Lambeth", zone_group: london, cerc_id: 22, cerc_type: 1},
  {name: "Lewisham", zone_group: london, cerc_id: 23, cerc_type: 1},
  {name: "Merton", zone_group: london, cerc_id: 24, cerc_type: 1},
  {name: "Newham", zone_group: london, cerc_id: 25, cerc_type: 1},
  {name: "Redbridge", zone_group: london, cerc_id: 26, cerc_type: 1},
  {name: "Richmond upon Thames", zone_group: london, cerc_id: 27, cerc_type: 1},
  {name: "Southwark", zone_group: london, cerc_id: 29, cerc_type: 1},
  {name: "Sutton", zone_group: london, cerc_id: 30, cerc_type: 1},
  {name: "Tower Hamlets", zone_group: london, cerc_id: 31, cerc_type: 1},
  {name: "Waltham Forest", zone_group: london, cerc_id: 32, cerc_type: 1},
  {name: "Wandsworth", zone_group: london, cerc_id: 33, cerc_type: 1},
  {name: "Westminster", zone_group: london, cerc_id: 34, cerc_type: 1},
  {name: "Central London", zone_group: london, cerc_id: 55, cerc_type: 2},
  {name: "North London", zone_group: london, cerc_id: 56, cerc_type: 2},
  {name: "South London", zone_group: london, cerc_id: 57, cerc_type: 2},
  {name: "East London", zone_group: london, cerc_id: 58, cerc_type: 2},
  {name: "West London", zone_group: london, cerc_id: 59, cerc_type: 2},
  {name: "Slough", zone_group: london_surrounds, cerc_id: 28, cerc_type: 1},
  {name: "Elmbridge", zone_group: london_surrounds, cerc_id: 169, cerc_type: 1},
  {name: "Runnymede", zone_group: london_surrounds, cerc_id: 170, cerc_type: 1},
  {name: "Spelthorne", zone_group: london_surrounds, cerc_id: 171, cerc_type: 1},
  {name: "Mole Valley", zone_group: london_surrounds, cerc_id: 172, cerc_type: 1},
  {name: "Tandridge", zone_group: london_surrounds, cerc_id: 173, cerc_type: 1},
  {name: "Colchester", zone_group: essex, cerc_id: 63, cerc_type: 1},
  {name: "Chelmsford", zone_group: essex, cerc_id: 64, cerc_type: 1},
  {name: "Maldon", zone_group: essex, cerc_id: 167, cerc_type: 1},
  {name: "Cambridge", zone_group: cambridge, cerc_id: 65, cerc_type: 1}
])
