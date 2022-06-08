class Api::V1::TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy, :info]
  before_action :set_user, only: [:index]

  def index
    trips = Trip.user_trips(@user)
    render json: TripSerializer.new(trips)
  end

  def show
    weather = WeathersFacade.get_weather(@trip.area.lat, @trip.area.long)
    render json: TripInfoSerializer.trip_info(@trip, weather)
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
    @trip.update(trip_params)
    if @trip.save
      render json: TripSerializer.new(@trip)
    else
      database_error(@trip)
    end
  end

  def destroy
    @trip.destroy
  end

  def info
    render json: TripSerializer.new(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :area_id, :description, :start_date, :end_date)
  end
end
