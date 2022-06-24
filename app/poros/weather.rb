class Weather
  attr_reader :id,
              :date,
              :temp,
              :feels_like,
              :temp_min,
              :temp_max,
              :humidity,
              :weather,
              :weather_description,
              :weather_icon,
              :cloud_coverage,
              :wind_speed,
              :wind_direction,
              :wind_gust,
              :visibility,
              :precipitation_probability,
              :sunrise,
              :sunset,
              :result

  def initialize(data, sunrise, sunset)
    if data == "no data"
      @result = "Weather is currently Unavailable"
    else
      @id = nil
      @date = data[:dt_txt]
      @temp = data[:main][:temp]
      @feels_like = data[:main][:feels_like]
      @temp_min = data[:main][:temp_min]
      @temp_max = data[:main][:temp_max]
      @humidity = data[:main][:humidity]
      @weather = data[:weather][0][:main]
      @weather_description = data[:weather][0][:description].titleize
      @weather_icon = data[:weather][0][:icon]
      @cloud_coverage = data[:clouds][:all]
      @wind_speed = data[:wind][:speed]
      @wind_direction = data[:wind][:deg]
      @wind_gust = data[:wind][:gust]
      @visibility = data[:visibility]
      @precipitation_probability = data[:pop]
      @sunrise = Time.zone.at(sunrise).strftime("%D at %T %Z")
      @sunset = Time.zone.at(sunset).strftime("%D at %T %Z")
    end
  end

  def self.set_daily_info(array)
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

  def self.set_forecast(weather)
    if weather.instance_of?(Array)
      {forecast:
        weather.group_by {|w| w.date.split[0] }.map do |date, info|
         { date: date.split[0],
           weather: {
             low_temp: info.sort_by {|w| w.temp}.first.temp,
             high_temp: info.sort_by {|w| w.temp}.last.temp,
             cloud_coverage: set_daily_info(info).cloud_coverage,
             feels_like: set_daily_info(info).feels_like,
             humidity: set_daily_info(info).humidity,
             precipitation_probability: precipitation_calculation(info),
             visibility: set_daily_info(info).visibility,
             weather: set_daily_info(info).weather,
             weather_description: set_daily_info(info).weather_description,
             weather_icon: set_daily_info(info).weather_icon,
             wind_direction: set_daily_info(info).wind_direction,
             wind_gust: set_daily_info(info).wind_gust,
             wind_speed: set_daily_info(info).wind_speed
           }
         }
            end,
        today_sunrise: weather.first.sunrise,
        today_sunset: weather.first.sunset
      }
    else
      weather.result
    end
  end
end
