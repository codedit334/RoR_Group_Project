FactoryBot.define do
    factory :food do
      name { Faker::Food.dish }
      measurement_unit { Faker::Food.metric_measurement }
      price { Faker::Commerce.price(range: 0..100) }
      quantity { Faker::Number.between(from: 1, to: 100) }
      association :user
    end
end
  