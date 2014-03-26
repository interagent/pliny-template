# make sure this is set before Sinatra is required
ENV["RACK_ENV"] = "test"

require "rubygems"
require "bundler"

Bundler.require(:default, :test)

require "minitest/autorun"
require "rr"

require_relative "../lib/pliny"
