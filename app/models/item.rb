class Item < ApplicationRecord
  belongs_to :user
  has_many :trip_items, dependent: :destroy
  has_many :trips, through: :trip_items

  validates_presence_of :name, :category
  validates_numericality_of :count, greater_than: 0

  enum category:{
    "Tents" => 0,
    "Sleeping Bag" =>  1,
    "Stoves, Grills & Fuel" => 2,
    "Cookware" => 3,
    "Dishes" => 4,
    "Ropes" => 5,
    "Harnesses" => 6,
    "Belay & Rappel" => 7,
    "Crash Pads" => 8,
    "Quickdraws" => 9
  }
end
