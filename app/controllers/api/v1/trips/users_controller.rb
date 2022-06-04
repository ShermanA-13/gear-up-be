class Api::V1::Trips::UsersController < ApplicationController
  def index
    users = User.users_on_trip(params[:id])
    render json: UserSerializer.new(users)
  end
end
