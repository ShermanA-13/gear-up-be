class Api::V1::TripsController < ApplicationController
  def index
    if valid_params?(User, params[:user_id], "user")
      trips = Trip.user_trips(@object)
      render json: TripSerializer.new(trips)
    end
  end

  def show
    if valid_params?(Trip, params[:id], "trip")
      weather = WeathersFacade.get_weather(@object.area.lat, @object.area.long)
      render json: TripInfoSerializer.trip_info(@object, weather)
    end
  end

  def create
    trip = Trip.new(trip_params)
    trip.update(host_id: params[:user_id])
    if trip.save
      TripUser.create(user_id: params[:user_id], trip_id: trip.id, host: true)
      render json: TripSerializer.new(trip), status: :created
    else
      database_error(trip)
    end
  end

  def update
    if valid_params?(Trip, params[:id], "trip")
      @object.update(trip_params)
      if @object.save
        render json: TripSerializer.new(@object)
      else
        database_error(@object)
      end
    end
  end

  def destroy
    if valid_params?(Trip, params[:id], "trip")
      @object.destroy
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :area_id, :description, :start_date, :end_date)
    end
end
