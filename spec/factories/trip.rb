FactoryBot.define do
  factory :trip do
    name { Faker::Lorem.word }
    location { Faker::Movies::HarryPotter.location }
    start_date { Date.today }
    end_date { Date.today.next_day }
    description { Faker::Movies::HarryPotter.quote }
    host_id { Faker::Number.between(from: 1, to: 50) }
  end
end
