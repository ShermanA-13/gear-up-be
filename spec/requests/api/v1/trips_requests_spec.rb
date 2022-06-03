require 'rails_helper'

RSpec.describe 'Trips API' do
  describe 'get all trips' do
    it 'returns all trips' do
      trip_list = create_list(:trip, 5)

      get '/api/v1/trips'

      trips_response = JSON.parse(response.body, symbolize_names: true)
      trips = trips_response[:data]

      expect(response).to be_successful
      expect(trips.count).to eq(5)

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
      trip_params = {
        name: "Climbing",
        location: "Yosemite",
        description: "YOLO",
        host_id: 4,
        start_date: Date.today,
        end_date: Date.today.next_day
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/items", headers: headers, params: JSON.generate(trip: trip_params)

      new_trip = Trip.last

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(new_trip.name).to eq(trip_params[:name])
      expect(new_trip.location).to eq(trip_params[:location])
      expect(new_trip.description).to eq(trip_params[:description])
      expect(new_trip.host_id).to eq(trip_params[:host_id])
      expect(new_trip.start_date).to eq(trip_params[:start_date])
      expect(new_trip.end_date).to eq(trip_params[:end_date])
    end
  end
end
