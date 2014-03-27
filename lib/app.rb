module App
end

require_relative "endpoints/base"
Pliny::Utils.require_relative_glob("lib/endpoints/**/*.rb")

require_relative "routes"
