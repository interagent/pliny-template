module Endpoints
  # The base class for all Sinatra-based endpoints. Use sparingly.
  class Base < Sinatra::Base
    register Pliny::Extensions::Instruments
    register Sinatra::Namespace

    configure :development do
      register Sinatra::Reloader
    end

    not_found do
      content_type :json
      status 404
      "{}"
    end
  end
end
