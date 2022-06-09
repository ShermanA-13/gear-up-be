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

  it 'returns an error if the user does not exist' do
    wrong_id = user.id + 1

    get "/api/v1/users/#{wrong_id}/items"

    items_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(items_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(items_response[:errors].first[:message]).to eq("No user with id #{wrong_id}")
    expect(items_response[:errors].first[:code]).to eq(404)
  end

  it "gets one item for user" do
    get "/api/v1/users/#{user.id}/items/#{items_list.first.id}"
    parsed = JSON.parse(response.body, symbolize_names: true)
    item = parsed[:data]
    expect(response).to be_successful
    expect(item[:id]).to eq(items_list.first.id.to_s)
    expect(item[:id]).to_not eq(items_list.last.id.to_s)
  end

  it 'returns an error if the item does not exist' do
    wrong_item_id = items_list.last.id + 1

    get "/api/v1/users/#{user.id}/items/#{wrong_item_id}"

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(item_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(item_response[:errors].first[:message]).to eq("No item with id #{wrong_item_id}")
    expect(item_response[:errors].first[:code]).to eq(404)
  end

  it 'returns an error if the items user does not exist' do
    wrong_user_id = user.id + 1

    get "/api/v1/users/#{wrong_user_id}/items/#{items_list.first.id}"

    items_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(items_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(items_response[:errors].first[:message]).to eq("No user with id #{wrong_user_id}")
    expect(items_response[:errors].first[:code]).to eq(404)
  end

  it "can create a new item" do
    item_params = {
      name: "Organic Crash Pad",
      description: "Super soft and thicc, heavy though",
      count: 1,
      category: 0,
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

  it 'wont create an item with missing attributes' do
    item_params = {
      description: "Super soft and thicc, heavy though",
      count: 1,
      user_id: user.id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/users/#{user.id}/items", headers: headers, params: JSON.generate(item: item_params)

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(item_response[:errors].first[:message]).to eq("Name can't be blank and Category can't be blank")
    expect(item_response[:errors].first[:status]).to eq("INPUT ERROR")
    expect(item_response[:errors].first[:code]).to eq(400)
  end

  it 'wont create an item with a nonexistant user' do
    item_params = {
      name: "Organic Crash Pad",
      description: "Super soft and thicc, heavy though",
      count: 1,
      category: "Crash Pads",
      user_id: user.id
    }

    wrong_user_id = user.id + 1

    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/users/#{wrong_user_id}/items", headers: headers, params: JSON.generate(item: item_params)

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(item_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(item_response[:errors].first[:message]).to eq("No user with id #{wrong_user_id}")
    expect(item_response[:errors].first[:code]).to eq(404)
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

  it 'can not update an item with wrong attributes' do
    item = create(:item, user_id: user.id)
    previous_name = item.name
    item_params = {name: ""}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/users/#{user.id}/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(item_response[:errors].first[:message]).to eq("Name can't be blank")
    expect(item_response[:errors].first[:status]).to eq("INPUT ERROR")
    expect(item_response[:errors].first[:code]).to eq(400)

    not_updated_item = Item.find_by(id: item.id)
    expect(not_updated_item.name).to eq(previous_name)
  end

  it 'can not update an item that does not exist' do
    id = create(:item, {user_id: user.id}).id
    item_params = {name: "Super Dope Climbing Thing"}
    headers = {"CONTENT_TYPE" => "application/json"}
    wrong_item_id = id + 1

    patch "/api/v1/users/#{user.id}/items/#{wrong_item_id}", headers: headers, params: JSON.generate({item: item_params})

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(item_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(item_response[:errors].first[:message]).to eq("No item with id #{wrong_item_id}")
    expect(item_response[:errors].first[:code]).to eq(404)
  end

  it 'can not update an item with the wrong user id' do
    id = create(:item, {user_id: user.id}).id
    item_params = {name: "Super Dope Climbing Thing"}
    headers = {"CONTENT_TYPE" => "application/json"}
    wrong_user_id = user.id + 1

    patch "/api/v1/users/#{wrong_user_id}/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(item_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(item_response[:errors].first[:message]).to eq("No user with id #{wrong_user_id}")
    expect(item_response[:errors].first[:code]).to eq(404)
  end

  it "can destroy an item" do
    item = create(:item, {user_id: user.id})
    expect(Item.count).to eq(6)

    delete "/api/v1/users/#{user.id}/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(5)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can not delete an item that does not exist' do
    item = create(:item, {user_id: user.id})
    expect(Item.count).to eq(6)
    wrong_item_id = item.id + 1

    delete "/api/v1/users/#{user.id}/items/#{wrong_item_id}"

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(item_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(item_response[:errors].first[:message]).to eq("No item with id #{wrong_item_id}")
    expect(item_response[:errors].first[:code]).to eq(404)
  end

  it 'can not delete an item with a nonexistant user' do
    item = create(:item, {user_id: user.id})
    expect(Item.count).to eq(6)
    wrong_user_id = user.id + 1

    delete "/api/v1/users/#{wrong_user_id}/items/#{item.id}"

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(404)
    expect(item_response[:errors].first[:status]).to eq("NOT FOUND")
    expect(item_response[:errors].first[:message]).to eq("No user with id #{wrong_user_id}")
    expect(item_response[:errors].first[:code]).to eq(404)
  end
end
