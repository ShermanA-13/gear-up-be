require 'rails_helper'

RSpec.describe "Weathers API" do
  describe 'all weathers' do
    it 'gets all weathers for a trip' do
      user = create(:user)
      area = Area.create!(
        id: 1728,
        name: "2. Fairfield Central",
        state: "Wyoming",
        url: "https://www.mountainproject.com/area/105827602/fairfield-central",
        long: "-108.84939",
        lat: "42.73982")
      trip_list = create_list(:trip, 5, area: area)
      trip = trip_list[0]

      user_trip1 = TripUser.create!(trip: trip_list[0], user: user, host: false)
      user_trip2 = TripUser.create!(trip: trip_list[1], user: user, host: false)
      user_trip3 = TripUser.create!(trip: trip_list[3], user: user, host: false)
      user_trip4 = TripUser.create!(trip: trip_list[4], user: user, host: false)

      get "/api/v1/areas/#{area.id}/weather"

      area_weather_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(area_weather_response).to have_key(:id)
      expect(area_weather_response[:id]).to be_a Integer
      expect(area_weather_response[:type]).to eq("weather info")
      expect(area_weather_response[:name]).to be_a String
      expect(area_weather_response[:weather]).to be_a Hash
      expect(area_weather_response[:weather][:forecast]).to be_an Array
      expect(area_weather_response[:weather][:forecast].first).to be_a Hash
      expect(area_weather_response[:weather][:forecast].first[:weather]).to be_a Hash
    end

    it 'returns an error if the area does not exist' do
      wrong_id = "something"

      get "/api/v1/areas/#{wrong_id}/weather"

      weathers_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(weathers_response[:errors].first[:status]).to eq("NOT FOUND")
      expect(weathers_response[:errors].first[:message]).to eq("No area with id #{wrong_id}")
      expect(weathers_response[:errors].first[:code]).to eq(404)
    end
  end
end