class WeathersFacade
  class << self
    def get_weather(lat, long)
      json = WeatherService.get_data(lat, long)
      # require "pry"; binding.pry
      if json[:cod] == "200"
        sunrise = json[:city][:sunrise]
        sunset = json[:city][:sunset]
        data = json[:list].map { |w_data| Weather.new(w_data, sunrise, sunset) }
      else
        "Weather is currently Unavailable"
      end
    end
  end
end
