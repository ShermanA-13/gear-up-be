class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  def show
    render json: UserSerializer.new(@user)
  end

  def create
    if User.exists?(email: params[:user][:email])
      user = User.find_by(email: params[:user][:email])
      render json: UserSerializer.new(user)
    else
      user = User.new(user_params)
      if user.save
        render json: UserSerializer.new(user), status: :created
      else
        database_error(user)
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :user_photo)
    end
end
