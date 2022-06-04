require "rails_helper"

RSpec.describe "Trip Items API" do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:area) { create(:area) }
  let!(:trip) { create(:trip, area_id: area.id) }

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

  it "can destroy a trip item" do
    item = create(:item, {user_id: user_1.id})
    trip_item = TripItem.create!(trip_id: trip.id, item_id: item.id)
    expect(trip.trip_items.count).to eq(11)

    delete "/api/v1/trips/#{trip.id}/items/#{trip_item.id}"

    expect(response).to be_successful
    expect(TripItem.count).to eq(10)
    expect(Item.count).to eq(11)
    expect { TripItem.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
