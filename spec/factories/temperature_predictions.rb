# @temperature=#<TemperaturePrediction
#   @min=10.0
#   @max=16.6>

FactoryBot.define do
  factory :temperature_prediction do
    min { 10.0 }
    max { 16.6 }

    initialize_with {
      new(
        min: min,
        max: max
      )
    }
  end
end
