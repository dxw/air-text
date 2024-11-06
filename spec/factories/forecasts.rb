# #<Forecast
# @obtained_at=2024-10-02 15:38:00 +0100
# @date=2024-10-02
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
#   @value=2
#   @daqi_label=LOW>
# @uv=2
# @pollen=-999
# @temperature=#<TemperaturePrediction
#   @min=10.0
#   @max=16.6>>

FactoryBot.define do
  factory :forecast do
    obtained_at { Time.current }
    date { Date.tomorrow }
    zone { FactoryBot.build(:forecast_zone) }
    air_pollution { FactoryBot.build(:air_pollution_prediction) }
    uv { FactoryBot.build(:uv_prediction) }
    pollen { FactoryBot.build(:pollen_prediction) }
    temperature { FactoryBot.build(:temperature_prediction) }

    trait :air_pollution_level_1 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 1) }
    end

    trait :air_pollution_level_2 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 2) }
    end

    trait :air_pollution_level_3 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 3) }
    end

    trait :air_pollution_level_4 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 4) }
    end

    trait :air_pollution_level_5 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 5) }
    end

    trait :air_pollution_level_6 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 6) }
    end

    trait :air_pollution_level_7 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 7) }
    end

    trait :air_pollution_level_8 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 8) }
    end

    trait :air_pollution_level_9 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 9) }
    end

    trait :air_pollution_level_10 do
      air_pollution { FactoryBot.build(:air_pollution_prediction, 10) }
    end

    initialize_with {
      new(
        obtained_at: obtained_at,
        date: date,
        zone: zone,
        air_pollution: air_pollution,
        uv: uv,
        pollen: pollen,
        temperature: temperature
      )
    }
  end
end
