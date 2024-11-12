# @zone=#<ForecastZone
#   @id=29
#   @name=Southwark
#   @type=1>

FactoryBot.define do
  factory :forecast_zone do
    id { 29 }
    name { "Southwark" }
    type { 1 }

    initialize_with { new(**attributes) }
  end
end
