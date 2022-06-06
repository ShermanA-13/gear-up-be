require 'rails_helper'

describe 'weather poro' do
  it 'exists and has attributes' do
    data = {
      main: {
        temp: 70.43,
        feels_like: 72.64,
        temp_min: 66.34,
        temp_max: 70.62,
        humidity: 22
      },
      weather: [
        main: "Rain",
        description: "light rain",
        icon: "10d"
      ],
      clouds: {all: 98},
      wind: {
        speed: 3.83,
        deg: 254,
        gust: 4.23
      },
      visibility: 9800,
      pop: 0.48
    }

    sunrise = 1654371032
    sunset = 1654422875

    weather = Weather.new(data, sunrise, sunset)

    expect(weather).to be_a Weather
    expect(weather.temp).to eq data[:main][:temp]
    expect(weather.feels_like).to eq data[:main][:feels_like]
    expect(weather.temp_min).to eq data[:main][:temp_min]
    expect(weather.temp_max).to eq data[:main][:temp_max]
    expect(weather.humidity).to eq data[:main][:humidity]
    expect(weather.weather).to eq data[:weather][0][:main]
    expect(weather.weather_description).to eq data[:weather][0][:description].titleize
    expect(weather.weather_icon).to eq data[:weather][0][:icon]
    expect(weather.cloud_coverage).to eq data[:clouds][:all]
    expect(weather.wind_speed).to eq data[:wind][:speed]
    expect(weather.wind_direction).to eq data[:wind][:deg]
    expect(weather.wind_gust).to eq data[:wind][:gust]
    expect(weather.visibility).to eq data[:visibility]
    expect(weather.percipitation_probability).to eq data[:pop]
    expect(weather.sunrise).to eq Time.zone.at(sunrise).strftime("%D at %T %Z")
    expect(weather.sunset).to eq Time.zone.at(sunset).strftime("%D at %T %Z")
  end
end
