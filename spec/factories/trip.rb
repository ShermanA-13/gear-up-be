FactoryBot.define do
  factory :trip do
    name { Faker::Lorem.word }
    location { Faker::Movies::HarryPotter.location }
    start_date { Faker::Date.between(from: Date.today, to: 1.week.from_now) }
    end_date { Faker::Date.between(from: 1.week.from_now, to: 3.weeks.from_now) }
    description { Faker::Movies::HarryPotter.quote }
    host_id { Faker::Number.between(from: 1, to: 50) }
  end
end
