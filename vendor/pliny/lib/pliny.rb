require "sinatra"
require "pliny/log"
require "pliny/utils"
require "pliny/middleware/cors"

module Pliny
  extend Log

  def self.initialize!
    Utils.require_relative_glob("config/initializers/*.rb")
  end

  def self.root
    @@root ||= File.expand_path("../../../../", __FILE__)
  end
end
