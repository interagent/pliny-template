require "rubygems"
require "bundler"

Bundler.require
require "./lib/app"

$stdout.sync = true

Pliny.initialize!

run Main
