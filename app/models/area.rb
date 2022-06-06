class Area < ApplicationRecord
  has_many :trips
  validates_presence_of :name, :state, :url, :lat, :long

  def self.find_all_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end
end
