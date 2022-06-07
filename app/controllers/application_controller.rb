class ApplicationController < ActionController::API

  def find_user(id)
    if User.exists?(id)
      @user = User.find(id)
    else
      @user = Error.new(404, "NOT FOUND", "No user with id #{id}")
      render json: ErrorSerializer.new(@user).serialized_json, status: 404
    end
  end
end
