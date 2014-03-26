module Pliny::Endpoints
  class Apps < Base
    namespace "/apps" do
      get do
        content_type :json
        status 200
        "[]"
      end
    end
  end
end
