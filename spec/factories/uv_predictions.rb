# @uv=#<UvPrediction
#   @level=3
#   @label_text="Moderate">

FactoryBot.define do
  factory :uv_prediction do
    level { 3 }
    label { "Moderate" }

    initialize_with {
      new(
        level: level,
        label: label
      )
    }
  end
end
