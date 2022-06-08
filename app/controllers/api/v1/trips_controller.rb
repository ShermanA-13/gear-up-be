class Api::V1::TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]
  before_action :set_user, only: [:index]

  def index
    # if valid_params?(User, params[:user_id], "user")
      trips = Trip.user_trips(@user)
      render json: TripSerializer.new(trips)
    # end
  end

  def show
    # if valid_params?(Trip, params[:id], "trip")
      weather = WeathersFacade.get_weather(@trip.area.lat, @trip.area.long)
      render json: TripInfoSerializer.trip_info(@trip, weather)
    # end
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
    # if valid_params?(Trip, params[:id], "trip")
      @trip.update(trip_params)
      if @trip.save
        render json: TripSerializer.new(@trip)
      else
        database_error(@trip)
      end
    # end
  end

  def destroy
    # if valid_params?(Trip, params[:id], "trip")
      @object.destroy
    # end
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :area_id, :description, :start_date, :end_date)
    end

    # def set_trip
    #   if valid_params?(Trip, params[:trip_id], "trip")
    #     @trip = @object
    #   end
    # end
    #
    # def set_user
    #   if valid_params?(User, params[:user_id], "user")
    #     @user = @object
    #   end
    # end
end
