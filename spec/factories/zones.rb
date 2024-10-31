FactoryBot.define do
  factory :zone do
    id { Faker::Internet.uuid }
    cerc_id { Faker::Number.between(from: 1, to: 1000000) }
    cerc_type { 1 }
    name { ["Barnet", "Brent", "Lewisham"].sample }
  end
end
