require "bundler"
Bundler.require

require "./lib/app"

$stdout.sync = true

App.initialize!

require "./lib/models"

run Routes
