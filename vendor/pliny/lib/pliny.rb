require "multi_json"
require "sinatra"

module Pliny ; end

require "pliny/commands/generator"
require "pliny/commands/migrator"
require "pliny/error"
require "pliny/extensions/instruments"
require "pliny/log"
require "pliny/request_store"
require "pliny/utils"
require "pliny/middleware/cors"
require "pliny/middleware/request_id"
require "pliny/middleware/request_store"
require "pliny/middleware/rescue_errors"
require "pliny/middleware/timeout"

module Pliny
  extend Log

  def self.initialize!
    Utils.require_relative_glob("config/initializers/*.rb")
  end

  def self.root
    @@root ||= File.expand_path("../../../../", __FILE__)
  end
end
