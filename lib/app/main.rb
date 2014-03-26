module App
  Main = Rack::Builder.new do
    use Rack::Instruments

    use Sinatra::Router do
      mount App::Endpoints::Apps

      # provides some default handlers like 404
      run App::Endpoints::Root
    end
  end
end
