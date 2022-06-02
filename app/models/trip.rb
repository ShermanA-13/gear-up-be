class Trip < ApplicationRecord
  has_many :trip_items, dependent: :destroy
  has_many :trip_users, dependent: :destroy
  has_many :users, through: :trip_users
  has_many :items, through: :trip_items

  validates_presence_of :name, :location, :start_date, :end_date, :description, :host_id
  # validates_inclusion_of :start_date, inclusion: { (Date.today)..(Date.today + 1.year) }
  # validates_inclusion_of :end_date, inclusion: { (Date.today)..(Date.today + 1.year) }
end
