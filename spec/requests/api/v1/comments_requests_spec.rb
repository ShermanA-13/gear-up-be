require 'rails_helper'

RSpec.describe "Comments API requests" do
  let!(:area) {create(:area)}
  let!(:trip) { create(:trip, area: area) }
  let!(:user_list) { create_list(:user, 2) }

  describe "Creating a comment" do
    it 'can create a comment' do
      comment_params = {
        message: "This is gonna be sick!"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/trips/#{trip.id}/#{user_list.first.id}/comments", headers: headers, params: JSON.generate(comment: comment_params)

      expect(response).to be_successful
      comment_response = JSON.parse(response.body, symbolize_names: true)

      expect(comment_response[:success]).to eq("Comment Created")
    end

    it 'throws an error if the user does not exist' do
      comment_params = {
        message: "This is gonna be sick!"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/trips/#{trip.id}/#{user_list.last.id + 1}/comments", headers: headers, params: JSON.generate(comment: comment_params)

      comment_response = JSON.parse(response.body, symbolize_names: true)
      expect(comment_response).to have_key(:errors)
    end

    it 'throws an error if the trip does not exist' do
      comment_params = {
        message: "This is gonna be sick!"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/trips/#{trip.id + 1}/#{user_list.first.id}/comments", headers: headers, params: JSON.generate(comment: comment_params)

      comment_response = JSON.parse(response.body, symbolize_names: true)
      expect(comment_response).to have_key(:errors)
    end
  end

  describe 'deleting a comment' do
    it 'can delete a comment' do
      comment = Comment.create!(trip: trip, user: user_list.first, message: "This is gonna be sick!")

      expect(Comment.all.count).to eq(1)
      delete "/api/v1/trips/#{trip.id}/comments/#{comment.id}"

      comment_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(Comment.all.count).to eq(0)
      expect(comment_response[:success]).to eq("Comment Deleted")
    end
  end
end
