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

  describe 'get one user' do
    it 'can get a user by id' do
      users_list = create_list(:user, 3)

      get "/api/v1/users/#{users_list.first.id}"

      user_response = JSON.parse(response.body, symbolize_names: true)
      user = user_response[:data]

      expect(response).to be_successful

      expect(user[:id]).to eq(users_list.first.id)
      expect(user[:type]).to eq("user")
      expect(user[:attributes][:first_name]).to eq(users_list.first.first_name)
      expect(user[:attributes][:last_name]).to eq(users_list.first.last_name)
      expect(user[:attributes][:email]).to eq(users_list.first.email)
    end
  end


end
