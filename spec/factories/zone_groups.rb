FactoryBot.define do
  factory :zone_group do
    id { Faker::Internet.uuid }
    name { Faker::Address.city }
  end
end
