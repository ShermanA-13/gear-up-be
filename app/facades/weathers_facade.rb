class WeathersFacade
  class << self
    def get_weather(lat, long)
      json = WeatherService.get_data(lat, long)
      sunrise = json[:city][:sunrise]
      sunset = json[:city][:sunset]
      data = json[:list].map { |w_data| Weather.new(w_data, sunrise, sunset) }
    end
  end
end
