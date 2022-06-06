FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Hipster.sentence }
    count { Faker::Number.between(from: 1, to: 5) }
    category { Faker::Number.between(from: 0, to: 9) }
  end
end
