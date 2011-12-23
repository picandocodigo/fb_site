class ErrorDisplay
  attr_accessor :message, :code

  def initialize message, code
    @message = message
    @code = code
  end
end