module App
  def self.initialize!
    Pliny::Utils.require_relative_glob("#{App.root}/config/initializers/*.rb")
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

require_relative "../config/config"

require_relative "endpoints/base"
Pliny::Utils.require_relative_glob("#{App.root}/lib/endpoints/**/*.rb")

if File.exists?("#{App.root}/lib/mediators/base.rb")
  require_relative "mediators/base"
  Pliny::Utils.require_relative_glob("#{App.root}/lib/mediators/**/*.rb")
end

require_relative "routes"
