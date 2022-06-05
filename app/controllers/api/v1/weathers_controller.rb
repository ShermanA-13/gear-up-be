class Api::V1::WeathersController < ApplicationController
  # before_action :location

  def index
    weather = WeatherFacade.get_weather(location.lat, location.long)
    render json: WeatherSerializer.new(weather)
  end

  private
  def location
    trip = Trip.find(params[:trip_id])
    Area.find(trip.area_id)
  end
end