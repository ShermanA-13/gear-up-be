class Item < ApplicationRecord
  belongs_to :user
  has_many :trip_items, dependent: :destroy
  has_many :trips, through: :trip_items

  validates_presence_of :name, :category
  validates_numericality_of :count, greater_than: 0

  enum status:{
    "Tents" => 1,
    "Food" => 2,
    "Sleeping Bag" => 3,
    "Pads & Hammocks" => 4,
    "Stoves, Grills & Fuel" => 5,
    "Dishes" => 6,
    "Ropes" => 7,
    "Harnesses" => 8,
    "Belay & Rappel" => 9,
    "Crash Pads" => 10
  }
end
