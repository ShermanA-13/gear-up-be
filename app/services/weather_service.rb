class WeatherService < BaseService
  class << self
    def get_data(lat,long)
      response = conn("https://api.openweathermap.org").get("/data/2.5/forecast?lat=#{lat}&lon=#{long}&appid=#{api_key}&units=imperial")
      get_json(response)
    end
  end

  private

    def self.api_key
      ENV["weather_api_key"]
    end
end