require 'rails_helper'

RSpec.describe "TripUsers API" do
  describe 'getting a trips users' do
    it 'returns all users for a given trip' do
      users = create_list(:user, 5)
      trip = create(:trip)

      TripUser.create!(trip: trip, user: users[0], host: false)
      TripUser.create!(trip: trip, user: users[2], host: false)
      TripUser.create!(trip: trip, user: users[3], host: false)

      get "/api/v1/trips/#{trip.id}/users"

      expect(response).to be_successful
      trip_users_response = JSON.parse(response.body, symbolize_names: true)
      trip_users = trip_users_response[:data]

      expect(trip_users.count).to eq 3
      trip_users.each do |user|
        expect(user[:id]).to be_a String
        expect(user[:type]).to eq("user")
        expect(user[:attributes][:first_name]).to be_a String
        expect(user[:attributes][:last_name]).to be_a String
        expect(user[:attributes][:email]).to be_a String
      end
    end
  end

  describe 'creating trip_users' do
    it 'can make trip users' do
      users = create_list(:user, 5)
      trip = create(:trip)

      invited = [users[0].id, users[2].id, users[3].id]
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/trips/:id/users", headers: headers, params: JSON.generate(users: invited)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(TripUser.all.count).to eq(3)
      TripUser.all.each do |user|
        expect(user.host).to be false
        expect(invited.include?(user.id)).to be true
      end
    end
  end
end
