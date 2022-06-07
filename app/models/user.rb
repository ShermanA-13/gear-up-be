class User < ApplicationRecord
  has_many :items
  has_many :trip_items, through: :items
  has_many :trip_users
  has_many :trips, through: :trip_users

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  def self.users_on_trip(id)
    joins(:trip_users).where(trip_users: {trip_id: id})
  end
end
