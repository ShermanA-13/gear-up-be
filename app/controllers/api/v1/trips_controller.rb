class Api::V1::TripsController < ApplicationController
  def index
    trips = Trip.all
    render json: TripSerializer.new(trips)
  end

  def show
    trip = Trip.find(params[:id])
    render json: TripSerializer.new(trip)
  end
end
