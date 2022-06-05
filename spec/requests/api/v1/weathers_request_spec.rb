require 'rails_helper'

RSpec.describe "Weathers API" do
  describe 'all weathers' do
    it 'gets all weathers for a trip' do

      get "/api/v1/trip/#{trip.id}/weather"

      weathers_response = JSON.parse(response.body, symbolize_names: true)
      weathers = weathers_response[:data]

      expect(response).to be_successful

      weathers.each do |weather|
        expect(weather[:id]).to be_a String
        expect(weather[:type]).to eq("weather")
        expect(weather[:attributes][:temp]).to be_a String
        expect(weather[:attributes][:feels_like]).to be_a String
        expect(weather[:attributes][:temp_min]).to be_a String
        expect(weather[:attributes][:temp_max]).to be_a String
        expect(weather[:attributes][:humidity]).to be_a String
        expect(weather[:attributes][:weather]).to be_a String
        expect(weather[:attributes][:weather_description]).to be_a String
        expect(weather[:attributes][:weather_icon]).to be_a String
        expect(weather[:attributes][:cloud_coverage]).to be_a String
        expect(weather[:attributes][:wind_speed]).to be_a String
        expect(weather[:attributes][:wind_direction]).to be_a String
        expect(weather[:attributes][:wind_gust]).to be_a String
        expect(weather[:attributes][:visibility]).to be_a String
        expect(weather[:attributes][:percipitation_probability]).to be_a String
        expect(weather[:attributes][:sunrise]).to be_a String
        expect(weather[:attributes][:sunset]).to be_a String
      end
    end
  end
end