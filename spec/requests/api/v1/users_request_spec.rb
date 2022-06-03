require 'rails_helper'

RSpec.describe "Users API" do
  describe 'all users' do
    it 'gets all users' do
      users_list = create_list(:user, 5)

      get '/api/v1/users'

      users_response = JSON.parse(response.body, symbolize_names: true)
      users = users_response[:data]

      expect(response).to be_successful

      users.each do |user|
        expect(user[:id]).to be_a String
        expect(user[:type]).to eq("user")
        expect(user[:attributes][:first_name]).to be_a String
        expect(user[:attributes][:last_name]).to be_a String
        expect(user[:attributes][:email]).to be_a String
      end
    end
  end
end
