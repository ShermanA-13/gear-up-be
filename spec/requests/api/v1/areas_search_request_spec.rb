require "rails_helper"

RSpec.describe "Areas API" do
  let!(:area_list) { create_list(:area, 4) }
  let!(:devils_lake) {
    Area.create!(
      name: "Devil's Lake",
      state: "WI",
      url: "www.mountainproject.com/devils_lake",
      lat: "43.41444124923926",
      long: "-89.70718195587138"
    )
  }

  it "finds all areas by name" do
    expect(Area.all.count).to eq(5)
    get "/api/v1/areas/find_all?name=dev"
    parsed = JSON.parse(response.body, symbolize_names: true)
    results = parsed[:data]

    expect(response).to be_successful
    expect(results.count).to eq(1)
    expect(results[0][:attributes][:name]).to eq("Devil's Lake")
    expect(results[0][:attributes][:name]).to_not eq(area_list.sample.name)
  end

  it 'returns an error if search is missing' do
    get "/api/v1/areas/find_all?"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(parsed[:errors].first[:status]).to eq("EMPTY SEARCH")
    expect(parsed[:errors].first[:code]).to eq(400)
    expect(parsed[:errors].first[:message]).to eq("Search can not be empty")
  end

  it 'returns an error if search is blank' do
    get "/api/v1/areas/find_all?name="
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(parsed[:errors].first[:status]).to eq("EMPTY SEARCH")
    expect(parsed[:errors].first[:code]).to eq(400)
    expect(parsed[:errors].first[:message]).to eq("Search can not be empty")
  end
end
