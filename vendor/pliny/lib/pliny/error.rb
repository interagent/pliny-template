module Pliny::Error
  class Base < StandardError
    attr_accessor :status
  end

  class ServiceUnavailable < Base
    def initialize(message)
      @status = 503
      super
    end
  end
end
