require "uri"
require "sequel"
require "sequel/extensions/migration"

namespace :db do
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    next if Dir["./db/migrate/*.rb"].empty?
    Sequel.connect(ENV["DATABASE_URL"])
    Sequel::Migrator.apply(Sequel::Model.db, "./db/migrate")
    puts "Migrated to the latest"
  end

  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    next if Dir["./db/migrate/*.rb"].empty?
    Sequel.connect(ENV["DATABASE_URL"])
    Sequel::Migrator.apply(Sequel::Model.db, "./db/migrate", -1)
    puts "Rolled back."
  end

  desc "Nuke the database (drop all tables)"
  task :nuke, :env do |cmd, args|
    Sequel.connect(ENV["DATABASE_URL"])
    Sequel::Model.db.tables.each do |table|
      Sequel::Model.db.run(%{DROP TABLE "#{table}"})
    end
    puts "Nuked database"
  end

  desc "Reset the database"
  task :reset, [:env] => [:nuke, :migrate]

  desc "Create the database"
  task :create, :env do |cmd, args|
    uri = URI.join(ENV["DATABASE_URL"], "/").to_s
    db = Sequel.connect(uri)
    name = URI.parse(ENV["DATABASE_URL"]).path[1..-1]
    db.run(%{CREATE DATABASE "#{name}"})
    puts "Database created"
  end

  desc "Drop the database"
  task :drop, :env do |cmd, args|
    uri = URI.join(ENV["DATABASE_URL"], "/").to_s
    db = Sequel.connect(uri)
    name = URI.parse(ENV["DATABASE_URL"]).path[1..-1]
    db.run(%{DROP DATABASE IF EXISTS "#{name}"})
    puts "Database dropped"
  end

  namespace :schema do
    desc "Load the database schema"
    task :load, :env do |cmd, args|
      db = Sequel.connect(ENV["DATABASE_URL"])
      schema = File.read("./db/schema.sql")
      db.run(schema)
      puts "Loaded schema"
    end

    desc "Dump the database schema"
    task :dump, :env do |cmd, args|
      `pg_dump -i -s -x -O -f ./db/schema.sql #{ENV["DATABASE_URL"]}`
      puts "Dumped schema"
    end
  end

  desc "Setup the database"
  task :setup, [:env] => [:drop, :create]
end
