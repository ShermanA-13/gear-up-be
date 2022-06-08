class Item < ApplicationRecord
  belongs_to :user
  has_many :trip_items, dependent: :destroy
  has_many :trips, through: :trip_items

  validates_presence_of :name, :category
  validates_numericality_of :count, greater_than: 0
  validates_inclusion_of :category, in: [0..9]

  # enum category: {
  #    0 => "Tents",
  #    1 => "Sleeping Bag",
  #    2 => "Stoves, Grills & Fuel",
  #    3 => "Cookware",
  #    4 => "Dishes",
  #    5 => "Ropes",
  #    6 => "Harnesses",
  #    7 => "Belay & Rappel",
  #    8 => "Crash Pads",
  #    9 => "Quickdraws"
  # }
  # enum category: %w[tents sleeping_bag stoves_grills_fuel cookware dishes ropes harnesses belay_and_rappel crash_pads quickdraws]
end
