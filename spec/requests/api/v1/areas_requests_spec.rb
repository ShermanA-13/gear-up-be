require 'rails_helper'

RSpec.describe 'areas show page' do
  describe 'get one area' do
    it 'can return info for one area' do
      area = create(:area, id: 3)

      get "/api/v1/areas/#{area.id}"

      area_response = JSON.parse(response.body, symbolize_names: true)
      found_area = area_response[:data]
      expect(response).to be_successful

      expect(found_area[:id].to_i).to eq(area.id)
      expect(found_area[:type]).to eq("area")
      expect(found_area[:attributes][:name]).to eq(area.name)
      expect(found_area[:attributes][:state]).to eq(area.state)
      expect(found_area[:attributes][:url]).to eq(area.url)
      expect(found_area[:attributes][:lat]).to eq(area.lat)
      expect(found_area[:attributes][:long]).to eq(area.long)
    end
  end
end
