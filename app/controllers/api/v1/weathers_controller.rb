class Api::V1::WeathersController < ApplicationController
  before_action :set_trip, only: [:index]

  def index
    weather = WeathersFacade.get_weather(location.lat, location.long)
    render json: WeatherSerializer.new(weather)
  end

  private
  def location
    Area.find(@trip.area_id)
  end
end
