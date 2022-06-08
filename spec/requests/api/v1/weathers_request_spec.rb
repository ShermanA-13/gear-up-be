require 'rails_helper'

RSpec.describe "Weathers API" do
  describe 'all weathers' do
    it 'gets all weathers for a trip' do
      user = create(:user)
      area = Area.create!(
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

      weathers_response = JSON.parse(response.body, symbolize_names: true)
      weathers = weathers_response[:data]

      expect(response).to be_successful

      weathers.each do |weather|
        expect(weather[:id]).to be nil
        expect(weather[:type]).to eq("weather")
        expect(weather[:attributes][:temp]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:feels_like]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:temp_min]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:temp_max]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:humidity]).to be_a Integer
        expect(weather[:attributes][:weather]).to be_a String
        expect(weather[:attributes][:weather_description]).to be_a String
        expect(weather[:attributes][:weather_icon]).to be_a String
        expect(weather[:attributes][:cloud_coverage]).to be_a Integer
        expect(weather[:attributes][:wind_speed]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:wind_direction]).to be_a Integer
        expect(weather[:attributes][:wind_gust]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:visibility]).to be_a Integer
        expect(weather[:attributes][:percipitation_probability]).to be_a(Float).or be_a Integer
        expect(weather[:attributes][:sunrise]).to be_a String
        expect(weather[:attributes][:sunset]).to be_a String
      end
    end
  end
end