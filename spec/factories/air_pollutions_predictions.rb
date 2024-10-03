# @air_pollution=#<AirPollutionPrediction
#   @forecasted_at=2024-10-02 15:50:00 +0100
#   @nitrogen_dioxide=1>
#   @particulate_matter_10=1
#   @particulate_matter_2_5=1
#   @ozone=2
#   @overall_score=2
#   @overall_label=LOW>

FactoryBot.define do
  factory :air_pollution_prediction do
    forecasted_at { Time.current - 2.hours }
    nitrogen_dioxide { 1 }
    particulate_matter_10 { 1 }
    particulate_matter_2_5 { 2 }
    ozone { 2 }
    overall_score { 2 }
    overall_label { "LOW" }

    initialize_with {
      new(
        forecasted_at: forecasted_at,
        nitrogen_dioxide: nitrogen_dioxide,
        particulate_matter_10: particulate_matter_10,
        particulate_matter_2_5: particulate_matter_2_5,
        ozone: ozone,
        overall_score: overall_score,
        overall_label: overall_label
      )
    }
  end
end
