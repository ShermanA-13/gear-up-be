class Api::V1::TripsController < ApplicationController
  def index
    if find_user(params[:user_id]).class == User
      trips = Trip.user_trips(@user)
      render json: TripSerializer.new(trips)
    end
  end

  def show
    if find_trip(params[:id]).class == Trip
      weather = WeathersFacade.get_weather(@trip.area.lat, @trip.area.long)
      render json: TripInfoSerializer.trip_info(@trip, weather)
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
    if find_trip(params[:id]).class == Trip
      @trip.update(trip_params)
      if @trip.save
        render json: TripSerializer.new(@trip)
      else
        database_error(@trip)
      end
    end
  end

  def destroy
    if find_trip(params[:id]).class == Trip
      @trip.destroy
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :area_id, :description, :start_date, :end_date)
    end
end
