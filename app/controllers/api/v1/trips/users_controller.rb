class Api::V1::Trips::UsersController < ApplicationController
  def index
    users = User.users_on_trip(params[:id])
    render json: UserSerializer.new(users)
  end

  def create
    params[:users].each do |user|
      TripUser.create(trip_id: params[:id], user_id: user, host: false)
    end
    render status: :created
  end

  def update
    params[:users].each do |user|
      if !TripUser.exists?(user_id: user)
        # require "pry"; binding.pry
        TripUser.create(trip_id: params[:id], user_id: user, host: false)
      end
    end
    render status: :created
  end
end
