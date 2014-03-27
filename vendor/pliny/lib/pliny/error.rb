module Pliny::Error
  class Base < StandardError
    attr_accessor :id
    attr_accessor :status
  end

  class InternalServerError < Base
    def initialize(message="Internal server error.")
      @id = :internal_server_error
      @status = 500
      super(message)
    end
  end

  class ServiceUnavailable < Base
    def initialize(message="Service unavailable.")
      @id = :service_unavailable
      @status = 503
      super(message)
    end
  end
end
