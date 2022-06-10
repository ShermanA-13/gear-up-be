class Api::V1::TripUsersController < ApplicationController
  before_action :set_trip, only: [:create, :update, :index]
  def index
    render json: UserSerializer.new(@trip.users)
  end

  def create
    params[:users].each do |user|
      TripUser.create(trip_id: @trip.id, user_id: user, host: false)
    end
    render status: :created, json: TripSerializer.new(@trip)
  end

  def update
    params[:users].each do |user|
      if !TripUser.exists?(user_id: user)
        TripUser.create(trip_id: @trip.id, user_id: user, host: false)
      end
    end
    @trip.users_to_remove(params[:users]).each { |user| user.destroy }
    render status: 200, json: TripSerializer.new(@trip)
  end
end
