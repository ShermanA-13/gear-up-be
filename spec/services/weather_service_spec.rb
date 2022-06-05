require 'rails_helper'

describe 'weather service' do
  it '.get_data returns info from lat and long arguments' do
    response = WeatherService.get_data(35,139)

    expect(response).to be_a Hash
    expect(response).to have_key(:list)
    expect(response[:list][0]).to have_key(:main)
    expect(response[:list][0][:main]).to have_key(:temp)
    expect(response[:list][0][:main]).to have_key(:feels_like)
    expect(response[:list][0][:main]).to have_key(:temp_min)
    expect(response[:list][0][:main]).to have_key(:temp_max)
    expect(response[:list][0][:main]).to have_key(:humidity)
    expect(response[:list][0]).to have_key(:weather)
    expect(response[:list][0][:weather][0]).to have_key(:main)
    expect(response[:list][0][:weather][0]).to have_key(:description)
    expect(response[:list][0][:weather][0]).to have_key(:icon)
    expect(response[:list][0]).to have_key(:clouds)
    expect(response[:list][0][:clouds]).to have_key(:all)
    expect(response[:list][0]).to have_key(:wind)
    expect(response[:list][0][:wind]).to have_key(:speed)
    expect(response[:list][0][:wind]).to have_key(:deg)
    expect(response[:list][0][:wind]).to have_key(:gust)
    expect(response[:list][0]).to have_key(:visibility)
    expect(response[:list][0]).to have_key(:pop)
    expect(response).to have_key(:city)
    expect(response[:city]).to have_key(:sunrise)
    expect(response[:city]).to have_key(:sunset)
  end
end