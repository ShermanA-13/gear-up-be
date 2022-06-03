# frozen_string_literal: true

class TripUser < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  validates :host, inclusion: { in: [true, false] }
end
