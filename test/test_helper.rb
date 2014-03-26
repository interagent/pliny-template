ENV["RACK_ENV"] = "test"

require "rubygems"
require "bundler"

Bundler.require(:default, :test)

require "minitest/autorun"
require "rr"

require_relative "../lib/pliny"

class MiniTest::Spec
  include Rack::Test::Methods
end

ENV.update(Pliny::Utils.parse_env("#{Pliny.root}/.env.test"))

Pliny.initialize!
