require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:trip_items).through(:items) }
    it { should have_many(:trip_users) }
    it { should have_many(:trips).through(:trip_users) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:email) }
  end

  describe "class methods" do
    it '.users_on_trip' do
      users = create_list(:user, 5)
      trip = create(:trip)
      TripUser.create!(trip: trip, user: users[0], host: false)
      TripUser.create!(trip: trip, user: users[2], host: false)
      TripUser.create!(trip: trip, user: users[3], host: false)

      expect(User.users_on_trip(trip.id)).to eq([users[0], users[2], users[3]])
    end
  end
end
