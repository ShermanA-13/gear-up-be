class Api::V1::UsersController < ApplicationController

  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  def show
    if find_user(params[:id]).class == User
      render json: UserSerializer.new(@user)
    end
  end

  def create
    if User.exists?(email: params[:user][:email])
      user = User.find_by(email: params[:user][:email])
      render json: UserSerializer.new(user)
    else
      require "pry"; binding.pry
      user = User.new(user_params)
      if user.save
        render json: UserSerializer.new(user), status: :created
      else
        creation_error(user)
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
