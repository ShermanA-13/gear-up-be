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
end
