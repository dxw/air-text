[
  {
    name: "Barking and Dagenham",
    cerc_id: 1,
    cerc_type: 1
  },
  {
    name: "Barnet",
    cerc_id: 2,
    cerc_type: 1
  },
  {
    name: "Bexley",
    cerc_id: 3,
    cerc_type: 1
  },
  {
    name: "Brent",
    cerc_id: 4,
    cerc_type: 1
  },
  {
    name: "Bromley",
    cerc_id: 5,
    cerc_type: 1
  },
  {
    name: "Camden",
    cerc_id: 6,
    cerc_type: 1
  },
  {
    name: "City of London",
    cerc_id: 7,
    cerc_type: 1
  },
  {
    name: "Croydon",
    cerc_id: 8,
    cerc_type: 1
  },
  {
    name: "Ealing",
    cerc_id: 9,
    cerc_type: 1
  },
  {
    name: "Enfield",
    cerc_id: 10,
    cerc_type: 1
  },
  {
    name: "Greenwich",
    cerc_id: 11,
    cerc_type: 1
  },
  {
    name: "Hackney",
    cerc_id: 12,
    cerc_type: 1
  },
  {
    name: "Hammersmith and Fulham",
    cerc_id: 13,
    cerc_type: 1
  },
  {
    name: "Haringey",
    cerc_id: 14,
    cerc_type: 1
  },
  {
    name: "Harrow",
    cerc_id: 15,
    cerc_type: 1
  },
  {
    name: "Havering",
    cerc_id: 16,
    cerc_type: 1
  },
  {
    name: "Hillingdon",
    cerc_id: 17,
    cerc_type: 1
  },
  {
    name: "Hounslow",
    cerc_id: 18,
    cerc_type: 1
  },
  {
    name: "Islington",
    cerc_id: 19,
    cerc_type: 1
  },
  {
    name: "Kensington and Chelsea",
    cerc_id: 20,
    cerc_type: 1
  },
  {
    name: "Kingston upon Thames",
    cerc_id: 21,
    cerc_type: 1
  },
  {
    name: "Lambeth",
    cerc_id: 22,
    cerc_type: 1
  },
  {
    name: "Lewisham",
    cerc_id: 23,
    cerc_type: 1
  },
  {
    name: "Merton",
    cerc_id: 24,
    cerc_type: 1
  },
  {
    name: "Newham",
    cerc_id: 25,
    cerc_type: 1
  },
  {
    name: "Redbridge",
    cerc_id: 26,
    cerc_type: 1
  },
  {
    name: "Richmond upon Thames",
    cerc_id: 27,
    cerc_type: 1
  },
  {
    name: "Slough",
    cerc_id: 28,
    cerc_type: 1
  },
  {
    name: "Southwark",
    cerc_id: 29,
    cerc_type: 1
  },
  {
    name: "Sutton",
    cerc_id: 30,
    cerc_type: 1
  },
  {
    name: "Tower Hamlets",
    cerc_id: 31,
    cerc_type: 1
  },
  {
    name: "Waltham Forest",
    cerc_id: 32,
    cerc_type: 1
  },
  {
    name: "Wandsworth",
    cerc_id: 33,
    cerc_type: 1
  },
  {
    name: "Westminster",
    cerc_id: 34,
    cerc_type: 1
  },
  {
    name: "Central London",
    cerc_id: 55,
    cerc_type: 2
  },
  {
    name: "North London",
    cerc_id: 56,
    cerc_type: 2
  },
  {
    name: "South London",
    cerc_id: 57,
    cerc_type: 2
  },
  {
    name: "East London",
    cerc_id: 58,
    cerc_type: 2
  },
  {
    name: "West London",
    cerc_id: 59,
    cerc_type: 2
  },
  {
    name: "Colchester",
    cerc_id: 63,
    cerc_type: 1
  },
  {
    name: "Chelmsford",
    cerc_id: 64,
    cerc_type: 1
  },
  {
    name: "Cambridge",
    cerc_id: 65,
    cerc_type: 1
  },
  {
    name: "Thurrock",
    cerc_id: 166,
    cerc_type: 1
  },
  {
    name: "Maldon",
    cerc_id: 167,
    cerc_type: 1
  },
  {
    name: "Reigate and Banstead",
    cerc_id: 168,
    cerc_type: 1
  },
  {
    name: "Elmbridge",
    cerc_id: 169,
    cerc_type: 1
  },
  {
    name: "Runnymede",
    cerc_id: 170,
    cerc_type: 1
  },
  {
    name: "Spelthorne",
    cerc_id: 171,
    cerc_type: 1
  },
  {
    name: "Mole Valley",
    cerc_id: 172,
    cerc_type: 1
  },
  {
    name: "Tandridge",
    cerc_id: 173,
    cerc_type: 1
  }
].each do |zone|
  Zone.seed(:cerc_id) do |s|
    s.name = zone[:name]
    s.cerc_id = zone[:cerc_id]
    s.cerc_type = zone[:cerc_type]
  end
end
