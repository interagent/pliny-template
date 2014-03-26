# Pliny

Pliny is a template Sinatra app to implement postgres-backed APIs.

It bundles:

- Sequel
- Honeybadger
- Unicorn

To get started:

```
bundle install
createdb pliny-development
foreman start web
```

There are some generators to help you get started:

```
$ bin/generate model artist
created model file ./lib/models/artist.rb
created migration ./db/migrate/1395873224_create_artist.rb
created test ./test/models/artist_test.rb

$ bin/generate mediator artist_creator
created mediator file ./lib/mediators/artist_creator.rb
```

## Tests

```
gem install rake
createdb pliny-test
rake
```
