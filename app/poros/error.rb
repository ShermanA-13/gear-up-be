class Error
  attr_reader :code, :status, :message, :id

  def initialize(code, status, message)
    @id = "Error"
    @code = code
    @status = status
    @message = message
  end
end
