# require "./app/serializers/weather_helper"

class TripInfoSerializer
  # include WeatherHelper
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

  def self.trip_info(trip, weather)
    {
      id: trip.id,
      type: "trip info",
      name: trip.name,
      start_date: trip.start_date,
      end_date: trip.end_date,
      host: User.find(trip.host_id).first_name,
      description: trip.description,
      lat: trip.area.lat,
      long: trip.area.long,
      area: trip.area.name,
      state: trip.area.state,
      users: trip.users.map do |user|
            {
              id: user.id,
              first_name: user.first_name,
              last_name: user.last_name,
              email: user.email,
              user_photo: user.user_photo
            }
          end,
      items: trip.items.map do |item|
            {
              id: item.id,
              name: item.name,
              description: item.description,
              count: item.count,
              category: item.category,
              owner: item.user.first_name
            }
          end,
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
