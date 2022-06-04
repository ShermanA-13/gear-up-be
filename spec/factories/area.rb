FactoryBot.define do
  factory :area do
    name { Faker::Movies::HarryPotter.location }
    state { Faker::Address.state }
    url { Faker::Internet.url }
    long { Faker::Number.decimal(l_digits:2).to_s }
    lat { Faker::Number.decimal(l_digits:2).to_s }
  end
end
