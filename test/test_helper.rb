ENV["RACK_ENV"] = "test"

require "rubygems"
require "bundler"

Bundler.require(:default, :test)

require "minitest/spec"
require "minitest/autorun"
require "rr"
require "./lib/pliny"

class MiniTest::Spec
  include Rack::Test::Methods
end
