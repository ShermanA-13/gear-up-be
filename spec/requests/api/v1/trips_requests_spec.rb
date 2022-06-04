require 'rails_helper'

RSpec.describe 'Trips API' do
  describe 'get all trips' do
    it 'returns all trips' do
      user = create(:user)
      trip_list = create_list(:trip, 5)
      user_trip1 = TripUser.create!(trip: trip_list[0], user: user, host: false)
      user_trip2 = TripUser.create!(trip: trip_list[1], user: user, host: false)
      user_trip3 = TripUser.create!(trip: trip_list[3], user: user, host: false)
      user_trip4 = TripUser.create!(trip: trip_list[4], user: user, host: false)

      get "/api/v1/users/#{user.id}/trips"

      trips_response = JSON.parse(response.body, symbolize_names: true)
      trips = trips_response[:data]

      expect(response).to be_successful
      expect(trips.count).to eq(4)

      trips.each do |trip|
        expect(trip).to have_key(:id)
        expect(trip[:id]).to be_a String

        expect(trip[:type]).to eq("trip")

        expect(trip[:attributes][:name]).to be_a String
        expect(trip[:attributes][:description]).to be_a String
        expect(trip[:attributes][:location]).to be_a String
        expect(trip[:attributes][:host_id]).to be_an Integer
        expect(trip[:attributes][:end_date]).to be_a String
        expect(trip[:attributes][:start_date]).to be_a String
      end
    end
  end

  describe 'get one trip' do
    it 'can retrieve one trips information' do
      trip_list = create_list(:trip, 5)
      trip = trip_list.first

      get "/api/v1/trips/#{trip.id}"

      trips_response = JSON.parse(response.body, symbolize_names: true)
      trip = trips_response[:data]

      expect(response).to be_successful

      expect(trip).to have_key(:id)
      expect(trip[:id]).to be_a String

      expect(trip[:type]).to eq("trip")

      expect(trip[:attributes][:name]).to be_a String
      expect(trip[:attributes][:description]).to be_a String
      expect(trip[:attributes][:location]).to be_a String
      expect(trip[:attributes][:host_id]).to be_an Integer
      expect(trip[:attributes][:end_date]).to be_a String
      expect(trip[:attributes][:start_date]).to be_a String
    end
  end

  describe 'post trip' do
    it 'can create a new trip' do
      user = create(:user)
      trip_params = {
        name: "Climbing",
        location: "Yosemite",
        description: "YOLO",
        start_date: Date.today,
        end_date: Date.today.next_day
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users/#{user.id}/trips", headers: headers, params: JSON.generate(trip: trip_params)

      new_trip = Trip.last

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(new_trip.name).to eq(trip_params[:name])
      expect(new_trip.location).to eq(trip_params[:location])
      expect(new_trip.description).to eq(trip_params[:description])
      expect(new_trip.host_id).to eq(user.id)
      expect(new_trip.start_date).to eq(trip_params[:start_date])
      expect(new_trip.end_date).to eq(trip_params[:end_date])
    end
  end

  describe 'patch trips' do
    it 'can edit a trip' do
      trip = Trip.create(name: "Fun Days!",
                        location: "Fun Place",
                        start_date: Date.today,
                        end_date: Date.today.next_day,
                        description: "Whoop Whoop!",
                        host_id: 4)

      new_trip_edits = {
                location: "Better Place",
                description: "More Excitement!"
              }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/trips/#{trip.id}", headers: headers, params: JSON.generate(trip: new_trip_edits)

      expect(response).to be_successful
      updated_trip_response = JSON.parse(response.body, symbolize_names: true)
      updated_trip = updated_trip_response[:data]
      found_update = Trip.find(trip.id)

      expect(updated_trip[:attributes][:name]).to eq(trip.name)
      expect(updated_trip[:attributes][:location]).not_to eq(trip.location)
      expect(updated_trip[:attributes][:location]).to eq("Better Place")
      # expect(updated_trip[:attributes][:start_date]).to eq(trip.start_date)
      # expect(updated_trip[:attributes][:end_date]).to eq(trip.end_date)
      expect(updated_trip[:attributes][:host_id]).to eq(trip.host_id)
      expect(updated_trip[:attributes][:description]).not_to eq(trip.description)
      expect(updated_trip[:attributes][:description]).to eq("More Excitement!")

      expect(found_update.name).to eq(trip.name)
      expect(found_update.start_date).to eq(trip.start_date)
      expect(found_update.end_date).to eq(trip.end_date)
      expect(found_update.host_id).to eq(trip.host_id)
      expect(found_update.description).not_to eq(trip.description)
      expect(found_update.location).not_to eq(trip.location)
      expect(found_update.location).to eq("Better Place")
      expect(found_update.description).to eq("More Excitement!")
    end
  end
end
