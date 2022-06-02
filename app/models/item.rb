class Item < ApplicationRecord
  belongs_to :user
  has_many :trip_items, dependent: :destroy
  has_many :trips, through: :trip_items

  validates_presence_of :name, :category
  validates_numericality_of :count, greater_than: 0
end
