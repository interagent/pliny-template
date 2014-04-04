# Pliny

Pliny is a template Sinatra app for postgres-backed APIs.

It bundles some of the patterns we like to develop these apps:

- Models: very thin wrappers around the database
- Mediators: plain ruby classes to manipulate models
- Endpoints: the Sinatra equivalent of a Rails Controller
- Initializers: tiny files to configure libraries/etc (equivalent of Rails)

And gems/helpers to tie these together and support operations:

- [CORS middleware](vendor/pliny/lib/pliny/middleware/cors.rb) to allow JS developers to consume your API
- [Honeybadger](https://www.honeybadger.io/) for tracking exceptions
- [Log as data helpers](vendor/pliny/test/log_test.rb)
- [Minitest](https://github.com/seattlerb/minitest) for lean and fast testing
- [Puma](http://puma.io/) as the web server, [configured for optimal performance on Heroku](config/puma.rb)
- [Rack-test](https://github.com/brynary/rack-test) to test the API endpoints
- [Request IDs](vendor/pliny/lib/pliny/middleware/request_id.rb)
- [RequestStore](http://brandur.org/antipatterns), thread safe option to store data with the current request
- [RR](https://github.com/rr/rr/blob/master/doc/03_api_overview.md) for amazing mocks and stubs
- [Sequel](http://sequel.jeremyevans.net/) for ORM
- [Sequel-PG](https://github.com/jeremyevans/sequel_pg) because fuck mysql

## Getting started

Clone this repo, then:

```bash
$ bundle install
$ createdb pliny-development
$ foreman start web
```

There are some generators to help you get started:

```bash
$ bin/generate model artist
created model file ./lib/models/artist.rb
created migration ./db/migrate/1395873224_create_artist.rb
created test ./test/models/artist_test.rb

$ bin/generate mediator artists/creator
created base mediator ./lib/mediators/base.rb
created mediator file ./lib/mediators/artists/creator.rb
created test ./test/mediators/artists/creator_test.rb

$ bin/generate endpoint artists
created endpoint file ./lib/endpoints/artists.rb
add the following to lib/app/main:
  use App::Main::Artists
created test ./test/endpoints/artists_test.rb

$ bin/generate migration fix_something
created migration ./db/migrate/1395873228_fix_something.rb
```

To test your application:

```bash
createdb pliny-test
rake
```

## Meta

Created by Brandur Leach and Pedro Belo.
