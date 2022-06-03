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
user_1 = User.create!( first_name: "something", last_name:"this", email: "email@email.com")
user_2 = User.create!( first_name: "asda", last_name:"this", email: "cheese@email.com")
user_3 = User.create!( first_name: "monkey", last_name:"this", email: "foo@email.com")

item_1 = Item.create!( user_id: user_1.id, name: "Water Bottle", category: "Water", count: 5)
item_2 = Item.create!( user_id: user_1.id, name: "Trail Mix", category: "Snacks", count: 8)
item_3 = Item.create!( user_id: user_2.id, name: "Good Socks", category: "Clothes", count: 3)
item_4 = Item.create!( user_id: user_2.id, name: "Fancy Tent", category: "Tents", count: 1)

trip_1 = Trip.create!(
  name: "first trip",
  location: "somewhere",
  start_date: Date.today,
  end_date: Date.today.next_day,
  description: "baby's first trip",
  host_id: user_1.id
)

trip_2 = Trip.create!(
  name: "boo boo trip",
  location: "nowhere",
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