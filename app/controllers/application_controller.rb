class ApplicationController < ActionController::API
  def set_trip
    if valid_params?(Trip, params[:trip_id], "trip")
      @trip = @object
    end
  end

  def set_user
    if valid_params?(User, params[:user_id], "user")
      @user = @object
    end
  end

  def set_item
    if valid_params?(Item, params[:item_id], "item")
      @item = @object
    end
  end

  def set_area
    if valid_params?(Area, params[:area_id], "area")
      @area = @object
    end
  end

  def valid_params?(type, id, type_name)
    object_present?(type, id, type_name).class == type
  end

  def object_present?(type, id, type_name)
    if type.exists?(id)
      @object = type.find(id)
    else
      error = Error.new(404, "NOT FOUND", "No #{type_name} with id #{id}")
      not_found_error(error)
    end
  end

  def not_found_error(error)
    render json: ErrorSerializer.new(error).serialized_json, status: 404
  end

  def database_error(error_object)
    error = Error.new(400, "INPUT ERROR", error_object.errors.full_messages.to_sentence)
    render json: ErrorSerializer.new(error).serialized_json, status: 400
  end
end
