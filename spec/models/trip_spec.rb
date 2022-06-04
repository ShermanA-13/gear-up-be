require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'relationships' do
    it { should belong_to :area }
    it { should have_many :trip_items }
    it { should have_many :trip_users }
    it { should have_many(:users).through(:trip_users) }
    it { should have_many(:items).through(:trip_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :description }
    it { should validate_presence_of :host_id }

    # it { should validate_inclusion_of(:start_date).in_range(Date.today..Date.today.next) }

  end

  describe 'class methods' do
    it '.users_trips' do
      user = create(:user)
      area = create(:area)
      trip_list = create_list(:trip, 5, area: area)
      user_trip1 = TripUser.create!(trip: trip_list[0], user: user, host: false)
      user_trip2 = TripUser.create!(trip: trip_list[1], user: user, host: false)
      user_trip3 = TripUser.create!(trip: trip_list[3], user: user, host: false)
      user_trip4 = TripUser.create!(trip: trip_list[4], user: user, host: false)

      expect(Trip.user_trips(user.id)).to eq([trip_list[0], trip_list[1], trip_list[3], trip_list[4]])
    end
  end

  describe 'instance methods' do
    it '#users_to_remove' do
      area = create(:area)
      trip = create(:trip, area: area)
      users = create_list(:user, 4)

      trip_user1 = TripUser.create!(trip: trip, user: users[0], host: false)
      trip_user2 = TripUser.create!(trip: trip, user: users[1], host: false)
      trip_user3 = TripUser.create!(trip: trip, user: users[2], host: false)
      trip_user4 = TripUser.create!(trip: trip, user: users[3], host: false)

      expect(TripUser.all.count).to eq(4)

      expect(trip.users_to_remove([users[0].id, users[3].id])).to eq([trip_user2, trip_user3])
    end
  end
end
