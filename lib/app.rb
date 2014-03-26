# before anything else, pull in the main Pliny package
module App
end

require_relative "app/endpoints/base"

Pliny::Utils.require_relative_glob("lib/app/endpoints/**/*.rb")

require_relative "app/main"
