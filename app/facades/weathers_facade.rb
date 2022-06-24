class WeathersFacade
  class << self
    def get_weather(lat, long)
      json = WeatherService.get_data(lat, long)
      if json[:cod] == "200"
        sunrise = json[:city][:sunrise]
        sunset = json[:city][:sunset]
        data = json[:list].map { |w_data| Weather.new(w_data, sunrise, sunset) }
      else
        Weather.new("no data", nil, nil)
      end
    end
  end
end
