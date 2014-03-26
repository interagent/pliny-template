module Pliny::Endpoints
  # The base class for all Sinatra-based endpoints. Use sparingly.
  class Base < Sinatra::Base
    set :database, ENV["DATABASE_URL"]

    not_found do
      content_type :json
      status 404
      "{}"
    end
  end
end
