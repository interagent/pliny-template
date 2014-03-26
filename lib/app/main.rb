module App
  Main = Rack::Builder.new do
    use Rack::Instruments

    use Sinatra::Router do
      # mount all individual Sinatra apps here
      mount App::Endpoints::Apps

      # root app; but will also handle some defaults like 404
      run App::Endpoints::Root
    end
  end
end
