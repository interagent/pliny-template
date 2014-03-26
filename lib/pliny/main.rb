module Pliny
  Main = Rack::Builder.new do
    use Rack::Instruments

    use Sinatra::Router do
      mount Pliny::Endpoints::Apps

      # provides some default handlers like 404
      run Pliny::Endpoints::Root
    end
  end
end
