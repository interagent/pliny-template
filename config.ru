require "bundler"
Bundler.require

require "./lib/initializer"

$stdout.sync = true

run Routes
