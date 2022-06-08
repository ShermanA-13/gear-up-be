class ApplicationController < ActionController::API

  def object_present?(type, id, type_name)
    if type.exists?(id)
      @object = type.find(id)
    else
      @error = Error.new(404, "NOT FOUND", "No #{type_name} with id #{id}")
      not_found(@error)
    end
  end

  def not_found(error)
    render json: ErrorSerializer.new(@error).serialized_json, status: 404
  end

  def valid_params?(type, id, type_name)
    object_present?(type, id, type_name).class == type
  end

  def database_error(object)
    error = Error.new(400, "INPUT ERROR", object.errors.full_messages.to_sentence)
    render json: ErrorSerializer.new(error).serialized_json, status: 400
  end

  # def find_user(id)
  #   if User.exists?(id)
  #     @user = User.find(id)
  #   else
  #     @user = Error.new(404, "NOT FOUND", "No user with id #{id}")
  #     render json: ErrorSerializer.new(@user).serialized_json, status: 404
  #   end
  # end

  # def find_trip(id)
  #   if Trip.exists?(id)
  #     @trip = Trip.find(id)
  #   else
  #     @trip = Error.new(404, "NOT FOUND", "No trip with id #{id}")
  #     render json: ErrorSerializer.new(@trip).serialized_json, status: 404
  #   end
  # end

  # def find_item(id)
  #   if Item.exists?(id)
  #     @item = Item.find(id)
  #   else
  #     @item = Error.new(404, "NOT FOUND", "No item with id #{id}")
  #     render json: ErrorSerializer.new(@item).serialized_json, status: 404
  #   end
  # end

end
