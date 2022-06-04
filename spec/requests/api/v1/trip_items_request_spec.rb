require "rails_helper"

RSpec.describe "Trip Items API" do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:trip) { create(:trip) }

  let!(:user_1_items) { create_list :item, 5, {user_id: user_1.id} }
  let!(:user_2_items) { create_list :item, 5, {user_id: user_2.id} }

  let!(:user_1_trip_items) {
    user_1_items.map do |item|
      TripItem.create!(trip_id: trip.id, item_id: item.id)
    end
  }
  let!(:user_2_trip_items) {
    user_2_items.map do |item|
      TripItem.create!(trip_id: trip.id, item_id: item.id)
    end
  }

  it "gets all items for single trip" do
    binding.pry
    get "/api/v1/trips/#{trip.id}/items"
    parsed = JSON.parse(response.body, symbolize_names: true)
    trip_items = parsed[:data]

    expect(response).to be_successful
    expect(trip_items.count).to eq(10)

    trip_items.each do |item|
      expect(item[:id]).to be_a(String)
      expect(item[:attributes][:trip_id]).to eq(trip.id)
      expect(item[:attributes][:item_id]).to be_an(Integer)
    end
  end

  # it "can create a new item" do
  #   item_params = {
  #     name: "Organic Crash Pad",
  #     description: "Super soft and thicc, heavy though",
  #     count: 1,
  #     category: 7,
  #     user_id: user.id
  #   }
  #   headers = {"CONTENT_TYPE" => "application/json"}
  #
  #   post "/api/v1/users/#{user.id}/items", headers: headers, params: JSON.generate(item: item_params)
  #   created_item = Item.last
  #
  #   expect(response).to be_successful
  #   expect(created_item.name).to eq(item_params[:name])
  #   expect(created_item.description).to eq(item_params[:description])
  #   expect(created_item.count).to eq(item_params[:count])
  #   expect(created_item.category).to eq(item_params[:category])
  # end
  #
  # it "can update an item" do
  #   id = create(:item, {user_id: user.id}).id
  #   previous_name = Item.last.name
  #   item_params = {name: "Super Dope Climbing Thing"}
  #   headers = {"CONTENT_TYPE" => "application/json"}
  #
  #   patch "/api/v1/users/#{user.id}/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
  #   item = Item.find_by(id: id)
  #
  #   expect(response).to be_successful
  #   expect(item.name).to_not eq(previous_name)
  #   expect(item.name).to eq("Super Dope Climbing Thing")
  # end
  #
  # it "can destroy an item" do
  #   item = create(:item, {user_id: user.id})
  #   expect(Item.count).to eq(6)
  #
  #   delete "/api/v1/users/#{user.id}/items/#{item.id}"
  #
  #   expect(response).to be_successful
  #   expect(Item.count).to eq(5)
  #   expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  # end
end
