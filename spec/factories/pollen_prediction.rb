# @pollen=#<PollenPrediction
#   @value=3

FactoryBot.define do
  factory :pollen_prediction do
    value { 3 }

    initialize_with {
      new(
        value: value
      )
    }
  end
end
