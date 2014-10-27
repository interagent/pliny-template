source "https://rubygems.org"
ruby "2.1.2"

gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", "~> 0.4"
gem "pry"
gem "pry-doc"
gem "puma", "~> 2.9"
gem "rack-ssl"
gem "rake"
gem "rollbar"
gem "sequel", "~> 4.15"
gem "sequel-paranoid"
gem "sequel_pg", "~> 1.6", require: "sequel"
gem "sinatra", "~> 1.4", require: "sinatra/base"
gem "sinatra-contrib", require: ["sinatra/namespace", "sinatra/reloader"]
gem "sinatra-router"
gem "sucker_punch"

group :development, :test do
  gem "pry-byebug"
end

group :development do
  gem "dotenv"
end

group :test do
  gem "committee"
  gem "database_cleaner"
  gem "rack-test"
  gem "rspec"
end
