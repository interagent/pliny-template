require "multi_json"
require "sinatra/base"
require "sinatra/sequel"

abort("Missing DATABASE_URL") unless ENV["DATABASE_URL"]

class Pliny < Sinatra::Base
  set :database, ENV["DATABASE_URL"]
end
