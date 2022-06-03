# frozen_string_literal: true

class TripItem < ApplicationRecord
  belongs_to :trip
  belongs_to :item
  has_one :user, through: :item
end
