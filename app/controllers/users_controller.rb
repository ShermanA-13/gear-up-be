class UsersController < ApplicationController
  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user)
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
