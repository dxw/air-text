FactoryBot.define do
  factory :forecast_zone, class: Hash do
    id { 55 }
    name { "Central London" }
    type { 1 }

    initialize_with { attributes }
  end
end
