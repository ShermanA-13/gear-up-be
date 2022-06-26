class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :trip_items, through: :items
  has_many :trip_users, dependent: :destroy
  has_many :trips, through: :trip_users

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  def self.users_on_trip(id)
    joins(:trip_users).where(trip_users: {trip_id: id})
  end

  def items_on_trip(id)
    items.joins(:trip_items).where("trip_items.trip_id = ?", id)
  end

  def trip_items_delete(id)
    trip_items.where(trip_id: id)
  end

  def missing_trip_items(ids, trip)
    trip_items.where.not(item_id: ids).where(trip_id: trip.id)
  end
end
