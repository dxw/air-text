FactoryBot.define do
  factory :air_pollution_prediction, class: Hash do
    forecasted_at { Time.current - 2.hours }
    no2 { 1 }
    pm10 { 1 }
    pm2_5 { 2 }
    o3 { 2 }
    total { 2 }
    after(:build) do |air_pollution_prediction|
      label = case air_pollution_prediction[:total]
      when 1..3
        "LOW"
      when 4..6
        "MODERATE"
      when 7..9
        "HIGH"
      else
        "VERY HIGH"
      end
      air_pollution_prediction[:label] = label
    end

    trait :low do
      total { 2 }
      label { "LOW" }
      no2 { 1 }
      pm10 { 1 }
      pm2_5 { 2 }
      o3 { 2 }
    end

    trait :moderate do
      total { 4 }
      label { "MODERATE" }
      no2 { 4 }
      pm10 { 4 }
      pm2_5 { 4 }
      o3 { 4 }
    end

    trait :high do
      total { 8 }
      label { "HIGH" }
      no2 { 8 }
      pm10 { 8 }
      pm2_5 { 8 }
      o3 { 8 }
    end

    trait :very_high do
      total { 10 }
      label { "VERY HIGH" }
      no2 { 10 }
      pm10 { 10 }
      pm2_5 { 10 }
      o3 { 10 }
    end

    initialize_with { attributes }
  end
end
