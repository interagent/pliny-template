Routes = Rack::Builder.new do
  use Honeybadger::Rack
  use Rack::Instruments
  use Pliny::Middleware::CORS
  use Pliny::Middleware::RequestID
  use Pliny::Middleware::RequestStore, store: Pliny::RequestStore

  use Sinatra::Router do
    # mount all individual Sinatra apps here

    # root app; but will also handle some defaults like 404
    run Endpoints::Root
  end
end
