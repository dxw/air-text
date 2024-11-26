FactoryBot.define do
  factory :zone_group do
    id { Faker::Internet.uuid }
    name { "London" }
  end
end
