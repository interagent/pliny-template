module Pliny
  Main = Rack::Builder.new do
    use Sinatra::Router do
      mount Pliny::Endpoints::Root

      # provides some default handlers like 404
      run Pliny::Endpoints::Default
    end
  end
end
