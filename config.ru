require "bundler"
Bundler.require

require "./lib/app"

$stdout.sync = true

App.initialize!
App.require!(['lib/models'])

run Routes
