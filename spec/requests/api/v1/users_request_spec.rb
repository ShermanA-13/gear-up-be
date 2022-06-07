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

      expect(user[:id].to_i).to eq(users_list.first.id)
      expect(user[:type]).to eq("user")
      expect(user[:attributes][:first_name]).to eq(users_list.first.first_name)
      expect(user[:attributes][:last_name]).to eq(users_list.first.last_name)
      expect(user[:attributes][:email]).to eq(users_list.first.email)
    end

    it 'throws an error if the user does not exist' do
      user = create(:user)
      id = User.last.id + 1

      get "/api/v1/users/#{id}"

      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response.message).to eq("Not found")
    end
  end

  describe 'it can create a user' do
    it 'creates a user' do
      user_params = {
        first_name: "Jack",
        last_name: "Sparrow",
        email: "tHeRuMiSgOnE@pirates.org"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)

      new_user = User.last

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(new_user.first_name).to eq(user_params[:first_name])
      expect(new_user.last_name).to eq(user_params[:last_name])
      expect(new_user.email).to eq(user_params[:email])
    end

    it 'returns an existing user if there is one already' do
      User.create!(first_name: "Jack", last_name: "Sparrow", email: "tHeRuMiSgOnE@pirates.org")

      users = create_list(:user, 2)

      expect(User.all.count).to eq(3)

      user_params = {
        first_name: "Jack",
        last_name: "Sparrow",
        email: "tHeRuMiSgOnE@pirates.org"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(User.all.count).to eq(3)
    end
  end
end
