class Api::V1::TripsController < ApplicationController
  def index
    trips = Trip.user_trips(params[:user_id])
    render json: TripSerializer.new(trips)
  end

  def show
    trip = Trip.find(params[:id])
    render json: TripSerializer.new(trip)
  end

  def create
    trip = Trip.new(trip_params)
    trip.update(host_id: params[:user_id])
    if trip.save
      render json: TripSerializer.new(trip), status: :created
    end
  end

  def update
    trip = Trip.update(params[:id], trip_params)
    render json: TripSerializer.new(trip) if trip.save
  end

  

  private
    def trip_params
      params.require(:trip).permit(:name, :location, :description, :start_date, :end_date)
    end
end
