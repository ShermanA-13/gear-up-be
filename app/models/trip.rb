# frozen_string_literal: true

class Trip < ApplicationRecord
  has_many :trip_items, dependent: :destroy
  has_many :trip_users, dependent: :destroy
  has_many :users, through: :trip_users
  has_many :items, through: :trip_items

  validate :end_date_later_than_start
  validates_presence_of :name, :location, :start_date, :end_date, :description, :host_id
  validates_inclusion_of :start_date, in: Date.today..Date.today.next_year

  def end_date_later_than_start
    errors.add(:end_date, 'End date can not be before start date.') if end_date.present? && end_date < start_date
  end
end
