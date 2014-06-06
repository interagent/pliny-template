Rollbar.configure do |config|
  config.access_token = ENV["ROLLBAR_API_KEY"]
  config.use_sucker_punch
end

