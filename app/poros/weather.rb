class Weather
  attr_reader :temp,
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
              :percipitation_probability,
              :sunrise,
              :sunset

  def initialize(data, sunrise, sunset)
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
    @percipitation_probability = data[:pop]
    @sunrise = Time.zone.at(sunrise).strftime("%D at %T %Z")
    @sunset = Time.zone.at(sunset).strftime("%D at %T %Z")
  end
end