require 'rails_helper'

RSpec.describe 'Trips API' do
  describe 'all trips' do
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

        expect(item[:attributes][:name]).to be_a String
        expect(item[:attributes][:description]).to be_a String
        expect(item[:attributes][:location]).to be_a String
        expect(item[:attributes][:host_id]).to be_an Integer
        expect(item[:attributes][:end_date]).to be_a Date
        expect(item[:attributes][:start_date]).to be_a Date
      end
    end
  end
end
