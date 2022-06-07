class ApplicationController < ActionController::API

  def find_user(id)
    if User.exists?(id)
      @user = User.find(id)
    else
      @user = Error.new(404, "NOT FOUND", "No user with id #{id}")
      render json: ErrorSerializer.new(@user).serialized_json, status: 404
    end
  end

  def find_trip(id)
    if Trip.exists?(id)
      @trip = Trip.find(id)
    else
      @trip = Error.new(404, "NOT FOUND", "No trip with id #{id}")
      render json: ErrorSerializer.new(@trip).serialized_json, status: 404
    end
  end

  def creation_error(object)
    error = Error.new(400, "MISSING INFO", object.errors.full_messages.to_sentence)
    render json: ErrorSerializer.new(error).serialized_json, status: 400
  end
end
