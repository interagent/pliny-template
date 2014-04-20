unless ENV["TEST_LOGS"] == "true"
  module Pliny::Log
    def log(data, &block)
    end
  end
end
