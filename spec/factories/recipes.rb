FactoryBot.define do
    factory :recipe do
      name { Faker::Food.dish }
      preparation_time { Faker::Number.decimal(l_digits: 2) }
      cooking_time { Faker::Number.decimal(l_digits: 2) }
      description { Faker::Lorem.paragraph }
      public { Faker::Boolean.boolean }
      association :user
    end
end