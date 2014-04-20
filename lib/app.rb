module App
  def self.initialize!
    Pliny::Utils.require_glob("#{App.root}/config/initializers/*.rb")
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

require_relative "../config/config"

require_relative "endpoints/base"
Pliny::Utils.require_glob("#{App.root}/lib/endpoints/**/*.rb")

require_relative "mediators/base"
Pliny::Utils.require_glob("#{App.root}/lib/mediators/**/*.rb")

require_relative "routes"
