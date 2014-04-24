# make sure this is set before Sinatra is required
ENV["RACK_ENV"] = "test"

require "bundler"
Bundler.require(:default, :test)

require "minitest/autorun"
require "rr"

require_relative "../lib/app"

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

ENV.update(Pliny::Utils.parse_env("#{App.root}/.env.test"))

App.initialize!
App.require!(['lib/models/**/*'])

# pull in test initializers
Pliny::Utils.require_glob("#{App.root}/test/support/**/*.rb")
