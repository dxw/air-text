# @air_pollution=#<AirPollutionPrediction
#   @forecasted_at=2024-10-02 15:50:00 +0100
#   @nitrogen_dioxide=1>
#   @particulate_matter_10=1
#   @particulate_matter_2_5=1
#   @ozone=2
#   @value=2
#   @label=LOW>

FactoryBot.define do
  factory :air_pollution_prediction do
    forecasted_at { Time.current - 2.hours }
    nitrogen_dioxide { 1 }
    particulate_matter_10 { 1 }
    particulate_matter_2_5 { 2 }
    ozone { 2 }
    value { 2 }
    label { "LOW" }

    trait :low do
      value { 2 }
      label { "LOW" }
      nitrogen_dioxide { 1 }
      particulate_matter_10 { 1 }
      particulate_matter_2_5 { 2 }
      ozone { 2 }
    end

    trait :moderate do
      value { 4 }
      label { "MODERATE" }
      nitrogen_dioxide { 4 }
      particulate_matter_10 { 4 }
      particulate_matter_2_5 { 4 }
      ozone { 4 }
    end

    trait :high do
      value { 8 }
      label { "HIGH" }
      nitrogen_dioxide { 8 }
      particulate_matter_10 { 8 }
      particulate_matter_2_5 { 8 }
      ozone { 8 }
    end

    trait :very_high do
      value { 10 }
      label { "VERY HIGH" }
      nitrogen_dioxide { 10 }
      particulate_matter_10 { 10 }
      particulate_matter_2_5 { 10 }
      ozone { 10 }
    end

    trait 1 do
      value { 1 }
      label { "LOW" }
      nitrogen_dioxide { 1 }
      particulate_matter_10 { 1 }
      particulate_matter_2_5 { 1 }
      ozone { 1 }
    end

    trait 2 do
      value { 2 }
      label { "LOW" }
      nitrogen_dioxide { 2 }
      particulate_matter_10 { 2 }
      particulate_matter_2_5 { 2 }
      ozone { 2 }
    end

    trait 3 do
      value { 3 }
      label { "LOW" }
      nitrogen_dioxide { 3 }
      particulate_matter_10 { 3 }
      particulate_matter_2_5 { 3 }
      ozone { 3 }
    end

    trait 4 do
      value { 4 }
      label { "MODERATE" }
      nitrogen_dioxide { 4 }
      particulate_matter_10 { 4 }
      particulate_matter_2_5 { 4 }
      ozone { 4 }
    end

    trait 5 do
      value { 5 }
      label { "MODERATE" }
      nitrogen_dioxide { 5 }
      particulate_matter_10 { 5 }
      particulate_matter_2_5 { 5 }
      ozone { 5 }
    end

    trait 6 do
      value { 6 }
      label { "MODERATE" }
      nitrogen_dioxide { 6 }
      particulate_matter_10 { 6 }
      particulate_matter_2_5 { 6 }
      ozone { 6 }
    end

    trait 7 do
      value { 7 }
      label { "HIGH" }
      nitrogen_dioxide { 7 }
      particulate_matter_10 { 7 }
      particulate_matter_2_5 { 7 }
      ozone { 7 }
    end

    trait 8 do
      value { 8 }
      label { "HIGH" }
      nitrogen_dioxide { 8 }
      particulate_matter_10 { 8 }
      particulate_matter_2_5 { 8 }
      ozone { 8 }
    end

    trait 9 do
      value { 9 }
      label { "HIGH" }
      nitrogen_dioxide { 9 }
      particulate_matter_10 { 9 }
      particulate_matter_2_5 { 9 }
      ozone { 9 }
    end

    trait 10 do
      value { 10 }
      label { "VERY HIGH" }
      nitrogen_dioxide { 10 }
      particulate_matter_10 { 10 }
      particulate_matter_2_5 { 10 }
      ozone { 10 }
    end

    initialize_with { new(**attributes) }
  end
end
