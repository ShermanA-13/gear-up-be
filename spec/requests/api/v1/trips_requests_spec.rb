require 'rails_helper'

RSpec.describe 'Trips API' do
  describe 'get all trips' do
    it 'returns all trips for a user' do
      user = create(:user)
      area = create(:area)
      trip_list = create_list(:trip, 5, area: area, host_id: user.id)
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
        expect(trip[:attributes][:area_id]).to be_a Integer
        expect(trip[:attributes][:host_id]).to be_an Integer
        expect(trip[:attributes][:end_date]).to be_a String
        expect(trip[:attributes][:start_date]).to be_a String
      end
    end

    it 'returns an error if the user does not exist' do
      user = create(:user)
      area = create(:area)
      trip_list = create_list(:trip, 5, area: area, host_id: user.id)
      user_trip1 = TripUser.create!(trip: trip_list[0], user: user, host: false)
      user_trip2 = TripUser.create!(trip: trip_list[1], user: user, host: false)
      user_trip3 = TripUser.create!(trip: trip_list[3], user: user, host: false)
      user_trip4 = TripUser.create!(trip: trip_list[4], user: user, host: false)

      wrong_id = user.id + 1

      get "/api/v1/users/#{wrong_id}/trips"

      trips_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(trips_response[:errors].first[:status]).to eq("NOT FOUND")
      expect(trips_response[:errors].first[:message]).to eq("No user with id #{wrong_id}")
      expect(trips_response[:errors].first[:code]).to eq(404)
    end
  end

  describe 'get one trip' do
    it 'can retrieve one trips information' do
      users = create_list(:user, 4)
      area = create(:area, long: "-108.84939", lat: "42.73982")
      trip = create(:trip, area: area, host_id: users[0].id)

      user_1_items = create_list(:item, 2, user: users[0])
      user_2_items = create_list(:item, 2, user: users[1])

      user_trip1 = TripUser.create!(trip: trip, user: users[0], host: false)
      user_trip2 = TripUser.create!(trip: trip, user: users[1], host: false)
      user_trip3 = TripUser.create!(trip: trip, user: users[2], host: false)
      user_trip4 = TripUser.create!(trip: trip, user: users[3], host: false)

      trip_item1 = TripItem.create!(trip: trip, item: user_1_items[0])
      trip_item1 = TripItem.create!(trip: trip, item: user_1_items[1])
      trip_item1 = TripItem.create!(trip: trip, item: user_2_items[0])
      trip_item1 = TripItem.create!(trip: trip, item: user_2_items[1])

      get "/api/v1/trips/#{trip.id}"

      trips_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(trips_response).to have_key(:id)
      expect(trips_response[:id]).to be_a Integer
      expect(trips_response[:type]).to eq("trip info")
      expect(trips_response[:name]).to be_a String
      expect(trips_response[:description]).to be_a String
      expect(trips_response[:area]).to be_a String
      expect(trips_response[:host]).to be_an String
      expect(trips_response[:end_date]).to be_a String
      expect(trips_response[:start_date]).to be_a String
      expect(trips_response[:lat]).to be_a String
      expect(trips_response[:long]).to be_a String
      expect(trips_response[:state]).to be_a String
      expect(trips_response[:users]).to be_an Array
      expect(trips_response[:users].first[:id]).to be_an Integer
      expect(trips_response[:users].first[:first_name]).to be_a String
      expect(trips_response[:users].first[:last_name]).to be_a String
      expect(trips_response[:users].first[:email]).to be_a String
      expect(trips_response[:items]).to be_an Array
      expect(trips_response[:items].first[:id]).to be_an Integer
      expect(trips_response[:items].first[:name]).to be_an String
      expect(trips_response[:items].first[:description]).to be_an String
      expect(trips_response[:items].first[:count]).to be_an Integer
      expect(trips_response[:items].first[:category]).to be_an Integer
      expect(trips_response[:items].first[:owner]).to be_an String
      expect(trips_response[:weather]).to be_a Hash
      expect(trips_response[:weather][:forecast]).to be_an Array
      expect(trips_response[:weather][:forecast].first).to be_a Hash
      expect(trips_response[:weather][:forecast].first[:weather]).to be_a Hash
    end

    it 'can retrieve one trips information' do
      users = create_list(:user, 4)
      area = create(:area, long: "asdf", lat: "sdf")
      trip = create(:trip, area: area, host_id: users[0].id)

      user_1_items = create_list(:item, 2, user: users[0])
      user_2_items = create_list(:item, 2, user: users[1])

      user_trip1 = TripUser.create!(trip: trip, user: users[0], host: false)
      user_trip2 = TripUser.create!(trip: trip, user: users[1], host: false)
      user_trip3 = TripUser.create!(trip: trip, user: users[2], host: false)
      user_trip4 = TripUser.create!(trip: trip, user: users[3], host: false)

      trip_item1 = TripItem.create!(trip: trip, item: user_1_items[0])
      trip_item1 = TripItem.create!(trip: trip, item: user_1_items[1])
      trip_item1 = TripItem.create!(trip: trip, item: user_2_items[0])
      trip_item1 = TripItem.create!(trip: trip, item: user_2_items[1])

      get "/api/v1/trips/#{trip.id}"

      trips_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(trips_response).to have_key(:id)
      expect(trips_response[:weather]).to eq("Weather is currently Unavailable")
    end

    it 'throws an error if the trip does not exist' do
      users = create_list(:user, 2)
      area = create(:area, long: "-108.84939", lat: "42.73982")
      trip = create(:trip, area: area, host_id: users[0].id)

      user_1_items = create_list(:item, 2, user: users[0])
      user_2_items = create_list(:item, 2, user: users[1])

      user_trip1 = TripUser.create!(trip: trip, user: users[0], host: false)
      user_trip2 = TripUser.create!(trip: trip, user: users[1], host: false)

      trip_item1 = TripItem.create!(trip: trip, item: user_1_items[0])
      trip_item1 = TripItem.create!(trip: trip, item: user_2_items[1])

      wrong_id = trip.id + 1

      get "/api/v1/trips/#{wrong_id}"

      trips_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(trips_response[:errors].first[:status]).to eq("NOT FOUND")
      expect(trips_response[:errors].first[:message]).to eq("No trip with id #{wrong_id}")
      expect(trips_response[:errors].first[:code]).to eq(404)
    end
  end

  describe 'post trip' do
    it 'can create a new trip' do
      user = create(:user)
      area = create(:area)
      trip_params = {
        name: "Climbing",
        area_id: area.id,
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
      expect(new_trip.area_id).to eq(trip_params[:area_id])
      expect(new_trip.description).to eq(trip_params[:description])
      expect(new_trip.host_id).to eq(user.id)
      expect(new_trip.start_date).to eq(trip_params[:start_date])
      expect(new_trip.end_date).to eq(trip_params[:end_date])
    end

    it 'wont create a trip with missing attributes' do
      user = create(:user)
      area = create(:area)
      trip_params = {
        area_id: area.id,
        description: "YOLO",
        end_date: Date.today.next_day
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users/#{user.id}/trips", headers: headers, params: JSON.generate(trip: trip_params)

      trip_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(trip_response[:errors].first[:status]).to eq("INPUT ERROR")
      expect(trip_response[:errors].first[:message]).to eq("Name can't be blank, Start date can't be blank, and Start date is not included in the list")
      expect(trip_response[:errors].first[:code]).to eq(400)
    end
  end

  describe 'patch trips' do
    it 'can edit a trip' do
      area = create(:area)
      trip = Trip.create(name: "Fun Days!",
                        area_id: area.id,
                        start_date: Date.today,
                        end_date: Date.today.next_day,
                        description: "Whoop Whoop!",
                        host_id: 4)

      new_trip_edits = {
                name: "Funner Days",
                description: "More Excitement!"
              }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/trips/#{trip.id}", headers: headers, params: JSON.generate(trip: new_trip_edits)

      expect(response).to be_successful
      updated_trip_response = JSON.parse(response.body, symbolize_names: true)
      updated_trip = updated_trip_response[:data]
      found_update = Trip.find(trip.id)

      expect(updated_trip[:attributes][:name]).not_to eq(trip.name)
      expect(updated_trip[:attributes][:name]).to eq("Funner Days")
      expect(updated_trip[:attributes][:host_id]).to eq(trip.host_id)
      expect(updated_trip[:attributes][:description]).not_to eq(trip.description)
      expect(updated_trip[:attributes][:description]).to eq("More Excitement!")

      expect(found_update.name).not_to eq(trip.name)
      expect(found_update.name).to eq("Funner Days")
      expect(found_update.area_id).to eq(trip.area_id)
      expect(found_update.start_date).to eq(trip.start_date)
      expect(found_update.end_date).to eq(trip.end_date)
      expect(found_update.host_id).to eq(trip.host_id)
      expect(found_update.description).not_to eq(trip.description)
      expect(found_update.description).to eq("More Excitement!")
    end

    it 'returns an error if the trip does not exist' do
      area = create(:area)
      trip = Trip.create(name: "Fun Days!",
                        area_id: area.id,
                        start_date: Date.today,
                        end_date: Date.today.next_day,
                        description: "Whoop Whoop!",
                        host_id: 4)

      new_trip_edits = {
                name: "Funner Days",
                description: "More Excitement!"
              }
      headers = {"CONTENT_TYPE" => "application/json"}

      wrong_id = trip.id + 1

      patch "/api/v1/trips/#{wrong_id}", headers: headers, params: JSON.generate(trip: new_trip_edits)

      trip_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(trip_response[:errors].first[:status]).to eq("NOT FOUND")
      expect(trip_response[:errors].first[:message]).to eq("No trip with id #{wrong_id}")
      expect(trip_response[:errors].first[:code]).to eq(404)
    end

    it 'returns an error if you try to update it with bad attributes' do
      area = create(:area)
      trip = Trip.create(name: "Fun Days!",
                        area_id: area.id,
                        start_date: Date.today,
                        end_date: Date.today.next_day,
                        description: "Whoop Whoop!",
                        host_id: 4)

      new_trip_edits = {
              start_date: Date.today.next_day,
              end_date: Date.today,
              }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/trips/#{trip.id}", headers: headers, params: JSON.generate(trip: new_trip_edits)

      trip_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)

      expect(trip_response[:errors].first[:status]).to eq("INPUT ERROR")
      expect(trip_response[:errors].first[:message]).to eq("End date can not be before start date.")
      expect(trip_response[:errors].first[:code]).to eq(400)
    end
  end

  describe "destroy trip" do
    it 'can delete a single trip' do
      area = create(:area)
      trips = create_list(:trip, 4, area: area)
      expect(Trip.all.count).to eq(4)

      delete "/api/v1/trips/#{trips[1].id}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(Trip.exists?(trips[1].id)).to be false
      expect(Trip.all.count).to eq(3)
    end

    it 'returns an error if the trip does not exist' do
      area = create(:area)
      trips = create_list(:trip, 4, area: area)
      expect(Trip.all.count).to eq(4)

      wrong_id = trips.last.id + 1
      delete "/api/v1/trips/#{wrong_id}"

      trip_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(trip_response[:errors].first[:status]).to eq("NOT FOUND")
      expect(trip_response[:errors].first[:message]).to eq("No trip with id #{wrong_id}")
      expect(trip_response[:errors].first[:code]).to eq(404)
    end
  end
end
