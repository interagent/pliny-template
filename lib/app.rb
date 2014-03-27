module App
end

require_relative "endpoints/base"
Pliny::Utils.require_relative_glob("lib/endpoints/**/*.rb")

if File.exists?("./lib/mediators/base.rb")
  require_relative "mediators/base"
  Pliny::Utils.require_relative_glob("lib/mediators/**/*.rb")
end

require_relative "routes"
