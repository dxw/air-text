FactoryBot.define do
  factory :forecast do
    obtained_at { Time.current }
    date { Date.tomorrow }
    zone { FactoryBot.build(:forecast_zone) }
    uv { 3 }
    pollen { 3 }
    temperature {
      {
        min: 10.0,
        max: 16.6
      }
    }

    transient do
      air_pollution_level { 1 }
    end
    air_pollution { FactoryBot.build(:air_pollution_prediction, total: air_pollution_level) }

    initialize_with { new(**attributes) }
  end
end
