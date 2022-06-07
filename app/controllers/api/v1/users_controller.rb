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
      user = User.new(user_params)
      if user.save
        render json: UserSerializer.new(user), status: :created
      else
        error = Error.new(400, "MISSING INFO", user.errors.full_messages.to_sentence)
        render json: ErrorSerializer.new(error).serialized_json, status: 400
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
