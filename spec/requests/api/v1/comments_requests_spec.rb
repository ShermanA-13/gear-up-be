require 'rails_helper'

RSpec.describe "Comments API requests" do
  let!(:area) {create(:area)}
  let!(:trip) { create(:trip, area: area) }
  let!(:user_list) { create_list(:user, 2) }

  describe "Creating a comment" do
    it 'can create a comment' do
      comment_params = {
        trip_id: trip.id,
        user_id: user_list.first.id,
        message: "This is gonna be sick!"

      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/comments", headers: headers, params: JSON.generate(comment: comment_params)

      expect(response).to be_successful
      comment_response = JSON.parse(response.body, symbolize_names: true)

      expect(comment_response[:success]).to eq("Comment Created")
    end
  end
end
