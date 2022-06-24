class Forecast

  # def self.set_daily_info(array)
  #   weather = array.select {|info| info.date.include?("12:00:00") }
  #   if weather.empty?
  #     array.sample
  #   else
  #     weather.first
  #   end
  # end
  #
  # def self.precipitation_calculation(array)
  #   array.map {|info| info.precipitation_probability }.sum / array.count
  # end
  #
  # def self.set_forecast(weather)
  #   if weather.instance_of?(Array)
  #     {forecast:
  #       weather.group_by {|w| w.date.split[0] }.map do |date, info|
  #        { date: date.split[0],
  #          weather: {
  #            low_temp: info.sort_by {|w| w.temp}.first.temp,
  #            high_temp: info.sort_by {|w| w.temp}.last.temp,
  #            cloud_coverage: set_daily_info(info).cloud_coverage,
  #            feels_like: set_daily_info(info).feels_like,
  #            humidity: set_daily_info(info).humidity,
  #            precipitation_probability: precipitation_calculation(info),
  #            visibility: set_daily_info(info).visibility,
  #            weather: set_daily_info(info).weather,
  #            weather_description: set_daily_info(info).weather_description,
  #            weather_icon: set_daily_info(info).weather_icon,
  #            wind_direction: set_daily_info(info).wind_direction,
  #            wind_gust: set_daily_info(info).wind_gust,
  #            wind_speed: set_daily_info(info).wind_speed
  #          }
  #        }
  #           end,
  #       today_sunrise: weather.first.sunrise,
  #       today_sunset: weather.first.sunset
  #     }
  #   else
  #     weather.result
  #   end
  # end
end
