Main = Rack::Builder.new do
  use Honeybadger::Rack
  use Rack::Instruments
  use Pliny::Middleware::CORS

  use Sinatra::Router do
    # mount all individual Sinatra apps here
    mount Endpoints::Apps

    # root app; but will also handle some defaults like 404
    run Endpoints::Root
  end
end
