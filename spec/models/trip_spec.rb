require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'relationships' do
    it { should have_many :trip_items }
    it { should have_many :trip_users }
    it { should have_many(:users).through(:trip_users) }
    it { should have_many(:items).through(:trip_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :description }
    it { should validate_presence_of :host_id }

    # it { should validate_inclusion_of(:start_date).in_range(Date.today..Date.today.next) }

  end

  describe 'class methods' do
    it '.users_trips' do
      user = create(:user)
      trip_list = create_list(:trip, 5)
      user_trip1 = TripUser.create!(trip: trip_list[0], user: user, host: false)
      user_trip2 = TripUser.create!(trip: trip_list[1], user: user, host: false)
      user_trip3 = TripUser.create!(trip: trip_list[3], user: user, host: false)
      user_trip4 = TripUser.create!(trip: trip_list[4], user: user, host: false)

      expect(Trip.user_trips(user.id)).to eq([trip_list[0], trip_list[1], trip_list[3], trip_list[4]])
    end
  end
end
