FactoryBot.define do
  factory :air_quality_alert do
    forecast { FactoryBot.build(:forecast) }

    initialize_with { new(**attributes) }
  end
end
