require "rubygems"
require "bundler"

Bundler.require
require "./lib/pliny"

$stdout.sync = true

Pliny.initialize!

run Pliny::Main
