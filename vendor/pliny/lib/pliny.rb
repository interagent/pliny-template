require "sinatra"

require "pliny/generator"
require "pliny/log"
require "pliny/request_store"
require "pliny/utils"
require "pliny/middleware/cors"
require "pliny/middleware/request_id"

module Pliny
  extend Log

  def self.initialize!
    Utils.require_relative_glob("config/initializers/*.rb")
  end

  def self.root
    @@root ||= File.expand_path("../../../../", __FILE__)
  end
end
