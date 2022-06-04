FactoryBot.define do
  factory :trip do
    name { Faker::Lorem.word }
    start_date { Date.today }
    end_date { Date.today.next_day }
    description { Faker::Movies::HarryPotter.quote }
    host_id { Faker::Number.between(from: 1, to: 10) }
  end
end
