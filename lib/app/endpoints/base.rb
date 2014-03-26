module App::Endpoints
  # The base class for all Sinatra-based endpoints. Use sparingly.
  class Base < Sinatra::Base
    register Sinatra::Namespace

    not_found do
      content_type :json
      status 404
      "{}"
    end
  end
end
