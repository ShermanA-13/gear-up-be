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
    it 'can make trip users that are invited' do
      users = create_list(:user, 5)
      trip = create(:trip)

      invited = [users[0].id, users[2].id, users[3].id]
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/trips/#{trip.id}/users", headers: headers, params: JSON.generate(users: invited)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(TripUser.all.count).to eq(3)
      TripUser.all.each do |trip_user|
        expect(trip_user.host).to be false
        expect(invited.include?(trip_user.user_id)).to be true
      end
    end

    it 'makes a trip user for the host when trip is created' do
      users = create_list(:user, 3)

      trip_params = {
            name: "Climbing",
            location: "Yosemite",
            description: "YOLO",
            start_date: Date.today,
            end_date: Date.today.next_day
          }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users/#{users[1].id}/trips", headers: headers, params: JSON.generate(trip_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(TripUser.all.count).to eq(1)
      expect(TripUser.last.user_id).to eq(users[1].id)
      expect(TripUser.last.host).to be true
    end
  end

  describe 'editing trip attendees/deleting trip_users' do
    it 'can add trip_users after trip created but not re-add users' do
      users = create_list(:user, 3)
      trip = create(:trip)

      TripUser.create!(user: users[0], trip: trip, host: false)
      TripUser.create!(user: users[2], trip: trip, host: false)

      expect(TripUser.all.count).to eq(2)

      invited = [users[0].id, users[1].id, users[2].id]
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/trips/#{trip.id}/users", headers: headers, params: JSON.generate(users: invited)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(TripUser.all.count).to eq(3)
      expect(TripUser.last.user_id).to eq(users[1].id)
    end

    it 'can remove a trip_user' do
      users = create_list(:user, 3)
      trip = create(:trip)

      users.each {|user| TripUser.create(trip: trip, user: user, host: false)}

      expect(TripUser.all.count).to eq(3)

      invited = [users[0].id, users[2].id]
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/trips/#{trip.id}/users", headers: headers, params: JSON.generate(users: invited)

      expect(response).to be_successful

      expect(TripUser.all.count).to eq(2)
      expect(TripUser.exists?(user_id: users[1].id)).to be false
    end
  end
end
