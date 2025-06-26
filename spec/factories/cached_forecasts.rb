FactoryBot.define do
  factory :cached_forecast do
    obtained_at { Time.current }
    data { FactoryBot.build_list(:forecast, 3) }

    transient do
      zone { nil }
    end

    after(:build) do |cached_forecast, evaluator|
      cached_forecast.zone = evaluator.zone || Zone.find_by_name(cached_forecast.data.first.zone[:name]) || FactoryBot.create(:zone)
    end
  end
end
