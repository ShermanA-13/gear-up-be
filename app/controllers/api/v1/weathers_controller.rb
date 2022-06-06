class Api::V1::WeathersController < ApplicationController

  def index
    weather = WeathersFacade.get_weather(location.lat, location.long)
    render json: WeatherSerializer.new(weather)
  end

  private
  def location
    trip = Trip.find(params[:trip_id])
    Area.find(trip.area_id)
  end
end
