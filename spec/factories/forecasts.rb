# #<Forecast
# @obtained_at=2024-10-02 15:38:00 +0100
# @forecast_for=2024-10-02
# @zone=#<ForecastZone
#   @id=29
#   @name=Southwark
#   @type=1>
# @air_pollution=#<AirPollutionPrediction
#   @forecasted_at=2024-10-02 15:50:00 +0100
#   @nitrogen_dioxide=1>
#   @particulate_matter_10=1
#   @particulate_matter_2_5=1
#   @ozone=2
#   @overall_score=2
#   @overall_label=LOW>
# @uv=2
# @pollen=-999
# @temperature=#<TemperaturePrediction
#   @min=10.0
#   @max=16.6>>

FactoryBot.define do
  factory :forecast do
    obtained_at { Time.current }
    forecast_for { Date.tomorrow }
    zone { FactoryBot.build(:forecast_zone) }
    air_pollution { FactoryBot.build(:air_pollution_prediction) }
    uv { FactoryBot.build(:uv_prediction) }
    pollen { -999 }
    temperature { FactoryBot.build(:temperature_prediction) }

    initialize_with {
      new(
        obtained_at: obtained_at,
        forecast_for: forecast_for,
        zone: zone,
        air_pollution: air_pollution,
        uv: uv,
        pollen: pollen,
        temperature: temperature
      )
    }
  end
end
