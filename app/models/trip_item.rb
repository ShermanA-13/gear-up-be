class TripItem < ApplicationRecord
  belongs_to :trip
  belongs_to :item
end
