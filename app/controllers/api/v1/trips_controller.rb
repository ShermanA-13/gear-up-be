class Api::V1::TripsController < ApplicationController
  def index
    trips = Trip.all
    render json: TripSerializer.new(trips)
  end

  def show
    trip = Trip.find(params[:id])
    render json: TripSerializer.new(trip)
  end

  def create
    trip = Trip.new(trip_params)
    if trip.save
      render json: TripSerializer.new(trip), status: :created
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :location, :description, :host_id, :start_date, :end_date)
    end
end
