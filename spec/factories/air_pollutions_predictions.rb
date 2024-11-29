FactoryBot.define do
  factory :air_pollution_prediction, class: Hash do
    forecasted_at { Time.current - 2.hours }
    nitrogen_dioxide { 1 }
    particulate_matter_10 { 1 }
    particulate_matter_2_5 { 2 }
    ozone { 2 }
    total { 2 }
    label { "LOW" }

    trait :low do
      total { 2 }
      label { "LOW" }
      nitrogen_dioxide { 1 }
      particulate_matter_10 { 1 }
      particulate_matter_2_5 { 2 }
      ozone { 2 }
    end

    trait :moderate do
      total { 4 }
      label { "MODERATE" }
      nitrogen_dioxide { 4 }
      particulate_matter_10 { 4 }
      particulate_matter_2_5 { 4 }
      ozone { 4 }
    end

    trait :high do
      total { 8 }
      label { "HIGH" }
      nitrogen_dioxide { 8 }
      particulate_matter_10 { 8 }
      particulate_matter_2_5 { 8 }
      ozone { 8 }
    end

    trait :very_high do
      total { 10 }
      label { "VERY HIGH" }
      nitrogen_dioxide { 10 }
      particulate_matter_10 { 10 }
      particulate_matter_2_5 { 10 }
      ozone { 10 }
    end

    initialize_with { attributes }
  end
end
