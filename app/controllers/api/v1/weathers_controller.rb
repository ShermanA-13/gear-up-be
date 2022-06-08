class Api::V1::WeathersController < ApplicationController

  def index
    weather = WeathersFacade.get_weather(location.lat, location.long)
    render json: WeatherSerializer.new(weather)
  end

  private
  def location
    Area.find(params[:area_id])
  end
end
