# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users = FactoryBot.create_list(:user, 10)

# FactoryBot.create_list(:item, 5, user: users[0])
# FactoryBot.create_list(:item, 8, user: users[1])
# FactoryBot.create_list(:item, 3, user: users[2])
# FactoryBot.create_list(:item, 5, user: users[3])
# FactoryBot.create_list(:item, 1, user: users[4])
# FactoryBot.create_list(:item, 5, user: users[5])
# FactoryBot.create_list(:item, 6, user: users[6])
# FactoryBot.create_list(:item, 5, user: users[7])
# FactoryBot.create_list(:item, 2, user: users[8])
# FactoryBot.create_list(:item, 5, user: users[9])

# FactoryBot.create_list(:trip, 3)
TripUser.destroy_all
TripItem.destroy_all
Trip.destroy_all
Item.destroy_all
User.destroy_all

user_1 = User.create!(id: 1, first_name: "something", last_name: "this", email: "email@email.com")
user_2 = User.create!(id: 2, first_name: "asda", last_name: "this", email: "cheese@email.com")
user_3 = User.create!(id: 3, first_name: "monkey", last_name: "this", email: "foo@email.com")

item_1 = Item.create!(id: 50, user_id: user_1.id, name: "Water Bottle", category: 1, count: 5)
item_2 = Item.create!(id: 51, user_id: user_1.id, name: "Trail Mix", category: 2, count: 8)
item_3 = Item.create!(id: 52, user_id: user_2.id, name: "Good Socks", category: 3, count: 3)
item_4 = Item.create!(id: 53, user_id: user_2.id, name: "Fancy Tent", category: 4, count: 1)

area = Area.create!(
  name: "2. Fairfield Central",
  state: "Wyoming",
  url: "https://www.mountainproject.com/area/105827602/fairfield-central",
  long: "-108.84939",
  lat: "42.73982"
)

trip_1 = Trip.create!(
  id: 1,
  name: "first trip",
  area_id: area.id,
  start_date: Date.today,
  end_date: Date.today.next_day,
  description: "baby's first trip",
  host_id: user_1.id
)

trip_2 = Trip.create!(
  id: 2,
  name: "boo boo trip",
  area_id: area.id,
  start_date: Date.today,
  end_date: Date.today.next_day,
  description: "trip I guess",
  host_id: user_3.id
)

TripUser.create!(trip_id: trip_1.id, user_id: user_1.id, host: true)
TripUser.create!(trip_id: trip_1.id, user_id: user_2.id, host: false)
TripUser.create!(trip_id: trip_2.id, user_id: user_3.id, host: true)
TripUser.create!(trip_id: trip_2.id, user_id: user_2.id, host: false)
TripUser.create!(trip_id: trip_2.id, user_id: user_1.id, host: false)
