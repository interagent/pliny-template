module App
end

require_relative "endpoints/base"
require_relative "request_store"

Pliny::Utils.require_relative_glob("lib/endpoints/**/*.rb")

require_relative "routes"
