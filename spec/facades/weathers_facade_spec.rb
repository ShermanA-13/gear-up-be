require 'rails_helper'

RSpec.describe WeathersFacade do
 it ".get_data" do
   weathers = WeathersFacade.get_weather(35,139)

   expect(weathers).to be_a(Array)
   weathers.each do |weather|
      expect(weather).to be_a Weather
    end
  end
end