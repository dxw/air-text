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

    initialize_with {
      new(
        forecasted_at: forecasted_at,
        nitrogen_dioxide: nitrogen_dioxide,
        particulate_matter_10: particulate_matter_10,
        particulate_matter_2_5: particulate_matter_2_5,
        ozone: ozone,
        value: value,
        label: label
      )
    }
  end
end
