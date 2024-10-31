FactoryBot.define do
  factory :cached_forecast do
    obtained_at { Time.current }
    association(:zone, factory: :zone)
    data { FactoryBot.build_list(:forecast, 3) }
  end
end
