source "https://rubygems.org"
ruby "2.1.0"

gem "honeybadger"
gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", path: "vendor/pliny"
gem "puma"
gem "sequel"
gem "sequel_pg", require: "sequel"
gem "sinatra", require: "sinatra/base"
gem "sinatra-contrib", require: ["sinatra/namespace", "sinatra/reloader"]
gem "sinatra-router"

group :development do
  gem "foreman"
end

group :test do
  gem "committee"
  gem "database_cleaner"
  gem "rack-test"
  gem "rr", require: false
end
