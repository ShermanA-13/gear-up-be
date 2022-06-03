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
      expect(item[:attributes][:category]).to be_an(Integer)
    end
  end

  it "gets one item for user" do
    get "/api/v1/users/#{user.id}/items/#{items_list.first.id}"
    parsed = JSON.parse(response.body, symbolize_names: true)
    item = parsed[:data]
    expect(response).to be_successful
    expect(item[:id]).to eq(items_list.first.id.to_s)
    expect(item[:id]).to_not eq(items_list.last.id.to_s)
  end
  #
  # it "can create a new item" do
  #   item_params = {
  #     name: "Ergonomic Wool Hat",
  #     description: "Fixie cold-pressed iphone pickled.",
  #     unit_price: 37.55,
  #     merchant_id: merchant_list[2].id
  #   }
  #   headers = {"CONTENT_TYPE" => "application/json"}
  #
  #   post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
  #   created_item = Item.last
  #
  #   expect(response).to be_successful
  #   expect(created_item.name).to eq(item_params[:name])
  #   expect(created_item.description).to eq(item_params[:description])
  #   expect(created_item.unit_price).to eq(item_params[:unit_price])
  #   expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  # end
  #
  # it "can destroy an item" do
  #   item = create(:item, {merchant_id: merchant_list[2].id})
  #   expect(Item.count).to eq(16)
  #
  #   delete "/api/v1/items/#{item.id}"
  #
  #   expect(response).to be_successful
  #   expect(Item.count).to eq(15)
  #   expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  # end
  #
  # it "can update an item" do
  #   id = create(:item, {merchant_id: merchant_list[2].id}).id
  #   previous_name = Item.last.name
  #   item_params = {name: "Small Wool Table"}
  #   headers = {"CONTENT_TYPE" => "application/json"}
  #
  #   patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
  #   item = Item.find_by(id: id)
  #
  #   expect(response).to be_successful
  #   expect(item.name).to_not eq(previous_name)
  #   expect(item.name).to eq("Small Wool Table")
  # end
end
