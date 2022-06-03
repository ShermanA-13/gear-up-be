# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

users = FactoryBot.create_list(:user, 10)

FactoryBot.create_list(:item, 5, user: users[0])
FactoryBot.create_list(:item, 8, user: users[1])
FactoryBot.create_list(:item, 3, user: users[2])
FactoryBot.create_list(:item, 5, user: users[3])
FactoryBot.create_list(:item, 1, user: users[4])
FactoryBot.create_list(:item, 5, user: users[5])
FactoryBot.create_list(:item, 6, user: users[6])
FactoryBot.create_list(:item, 5, user: users[7])
FactoryBot.create_list(:item, 2, user: users[8])
FactoryBot.create_list(:item, 5, user: users[9])

FactoryBot.create_list(:trip, 3)
