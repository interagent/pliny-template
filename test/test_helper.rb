# make sure this is set before Sinatra is required
ENV["RACK_ENV"] = "test"

require "bundler"
Bundler.require(:default, :test)

require "minitest/autorun"
require "rr"

require_relative "../lib/app"

class MiniTest::Spec
  include Rack::Test::Methods
end

ENV.update(Pliny::Utils.parse_env("#{App.root}/.env.test"))

App.initialize!

require_relative "../lib/models"
