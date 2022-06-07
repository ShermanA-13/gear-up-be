require "rails_helper"

RSpec.describe "Items API" do
  let!(:user) { create(:user) }
  let!(:items_list) { create_list :item, 5, {user_id: user.id} }

  it "gets all items for single user" do
    get "/api/v1/users/#{user.id}/items"
    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(response).to be_successful
    expect(items.count).to eq(5)

    items.each do |item|
      expect(item[:id]).to be_a(String)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:count]).to be_an(Integer)
      expect(item[:attributes][:category]).to be_an(String)
    end
  end

  it 'returns an error if the user does not exist' do
    wrong_id = user.id + 1

    get "/api/v1/users/#{wrong_id}/items"

    trips_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(trips_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(trips_response[:errors].first[:message]).to eq("No user with id #{wrong_id}")
    expect(trips_response[:errors].first[:code]).to eq(404)
  end

  it "gets one item for user" do
    get "/api/v1/users/#{user.id}/items/#{items_list.first.id}"
    parsed = JSON.parse(response.body, symbolize_names: true)
    item = parsed[:data]
    expect(response).to be_successful
    expect(item[:id]).to eq(items_list.first.id.to_s)
    expect(item[:id]).to_not eq(items_list.last.id.to_s)
  end

  it "can create a new item" do
    item_params = {
      name: "Organic Crash Pad",
      description: "Super soft and thicc, heavy though",
      count: 1,
      category: "Crash Pads",
      user_id: user.id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/users/#{user.id}/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.count).to eq(item_params[:count])
    expect(created_item.category).to eq(item_params[:category])
  end

  it "can update an item" do
    id = create(:item, {user_id: user.id}).id
    previous_name = Item.last.name
    item_params = {name: "Super Dope Climbing Thing"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/users/#{user.id}/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Super Dope Climbing Thing")
  end

  it "can destroy an item" do
    item = create(:item, {user_id: user.id})
    expect(Item.count).to eq(6)

    delete "/api/v1/users/#{user.id}/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(5)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
