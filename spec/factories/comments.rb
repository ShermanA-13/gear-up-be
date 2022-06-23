FactoryBot.define do
  factory :comment do
    trip { nil }
    user { nil }
    message { "MyText" }
  end
end
