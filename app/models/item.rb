class Item < ApplicationRecord
  belongs_to :user
  has_many :trip_items, dependent: :destroy
  has_many :trips, through: :trip_items

  validates_presence_of :name, :category
  validates_numericality_of :count, greater_than: 0

  enum category:{
    "Tents" => 1,
    "Sleeping Bag" => 2,
    "Stives, Grills & Fuel" => 3,
    "Cookware" => 4,
    "Dishes" => 5,
    "Ropes" => 6,
    "Harnesses" => 7,
    "Belay & Rappel" => 8,
    "Crash Pads" => 9,
    "Quickdraws" => 10
  }
end
