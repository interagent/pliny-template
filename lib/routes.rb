Routes = Rack::Builder.new do
  use Pliny::Middleware::RescueErrors if Config.rescue_errors.downcase == 'true'
  use Honeybadger::Rack::ErrorNotifier if Config.honeybadger_api_key
  use Pliny::Middleware::CORS
  use Pliny::Middleware::RequestID
  use Pliny::Middleware::RequestStore, store: Pliny::RequestStore
  use Pliny::Middleware::Timeout, timeout: Config.timeout.to_i if Config.timeout.to_i > 0
  use Rack::Deflater
  use Rack::MethodOverride
  use Rack::SSL if Config.force_ssl.downcase == 'true'

  use Pliny::Router do
    # mount all endpoints here
  end

  # root app; but will also handle some defaults like 404
  run Endpoints::Root
end
