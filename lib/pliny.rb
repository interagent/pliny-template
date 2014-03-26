module Pliny
  def self.initialize!
    Utils.require_relative_glob("config/initializers/*.rb")
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

require_relative "pliny/endpoints/base"
require_relative "pliny/utils"

Pliny::Utils.require_relative_glob("lib/pliny/endpoints/**/*.rb")

require_relative "pliny/main"
