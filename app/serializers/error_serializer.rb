class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialized_json
    {
      errors: [
        {
          status: @error_object.status,
          message: @error_object.message,
          code: @error_object.code
        }
      ]
    }
  end
end
