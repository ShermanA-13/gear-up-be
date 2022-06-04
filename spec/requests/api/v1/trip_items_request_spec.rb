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

  it "gets all trip items for single trip" do
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

  it "can create a new trip item" do
    item = Item.create!(
      name: "Organic Crash Pad",
      description: "Super soft and thicc, heavy though",
      count: 1,
      category: 7,
      user_id: user_1.id
    )

    trip_item_params = {
      trip_id: trip.id,
      item_id: item.id
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/trips/#{trip.id}/items", headers: headers, params: JSON.generate(trip_item: trip_item_params)
    created_trip_item = TripItem.last

    expect(response).to be_successful
    expect(created_trip_item.trip_id).to eq(trip_item_params[:trip_id])
    expect(created_trip_item.item_id).to eq(trip_item_params[:item_id])
  end
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
