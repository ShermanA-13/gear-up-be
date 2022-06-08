class Api::V1::TripUsersController < ApplicationController
  before_action :set_trip, only: [:create, :update]
  def index
    users = User.users_on_trip(params[:trip_id])
    render json: UserSerializer.new(users)
  end

  def create
    params[:users].each do |user|
      TripUser.create(trip_id: @trip.id, user_id: user, host: false)
    end
    render status: :created
  end

  def update
    # trip = Trip.find(params[:trip_id])
    params[:users].each do |user|
      if !TripUser.exists?(user_id: user)
        TripUser.create(trip_id: @trip.id, user_id: user, host: false)
      end
    end
    @trip.users_to_remove(params[:users]).each {|user| user.destroy}
    render status: 200
  end
end
