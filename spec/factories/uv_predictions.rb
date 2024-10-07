# @uv=#<UvPrediction
#   @level=3
#   @label_text="Moderate">

FactoryBot.define do
  factory :uv_prediction do
    value { 3 }

    initialize_with {
      new(
        value: value
      )
    }
  end
end
