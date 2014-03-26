require "rubygems"
require "bundler"

Bundler.require
require "./lib/pliny"

$stdout.sync = true

run Pliny::Main
