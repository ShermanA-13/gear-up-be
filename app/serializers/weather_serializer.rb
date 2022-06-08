class WeatherSerializer
  include JSONAPI::Serializer
  def self.find_info(array)
    weather = array.select {|info| info.date.include?("12:00:00") }
    if weather.empty?
      array.sample
    else
      weather.first
    end
  end

  def self.precipitation_calculation(array)
    array.map {|info| info.precipitation_probability }.sum / array.count
  end

  def self.area_weather(area, weather)
    {
      id: area.id,
      type: "weather info",
      name: area.name,
      weather: if weather.class == String
                  weather
              else
            {forecast:
              weather.group_by {|w| w.date.split[0] }.map do |date, info|
               { date: date.split[0],
               weather: {
                 low_temp: info.sort_by {|w| w.temp}.first.temp,
                 high_temp: info.sort_by {|w| w.temp}.last.temp,
                 cloud_coverage: find_info(info).cloud_coverage,
                 feels_like: find_info(info).feels_like,
                 humidity: find_info(info).humidity,
                 precipitation_probability: precipitation_calculation(info),
                 visibility: find_info(info).visibility,
                 weather: find_info(info).weather,
                 weather_description: find_info(info).weather_description,
                 weather_icon: find_info(info).weather_icon,
                 wind_direction: find_info(info).wind_direction,
                 wind_gust: find_info(info).wind_gust,
                 wind_speed: find_info(info).wind_speed
               }
             }
           end,
           today_sunrise: weather.first.sunrise,
           today_sunset: weather.first.sunset
        }
        end
      }
  end
end