require "sequel"
require "sequel/extensions/migration"
require "uri"

require "pliny/utils"

namespace :db do
  desc "Run database migrations"
  task :migrate do
    next if Dir["./db/migrate/*.rb"].empty?
    envs.each do |env_file, env|
      db = Sequel.connect(env["DATABASE_URL"])
      Sequel::Migrator.apply(db, "./db/migrate")
      puts "Migrated `#{name_from_uri(env["DATABASE_URL"])}`"
    end
  end

  desc "Rollback the database"
  task :rollback do
    next if Dir["./db/migrate/*.rb"].empty?
    envs.each do |env_file, env|
      db = Sequel.connect(env["DATABASE_URL"])
      Sequel::Migrator.apply(db, "./db/migrate", -1)
      puts "Rolled back `#{name_from_uri(env["DATABASE_URL"])}`"
    end
  end

  desc "Nuke the database (drop all tables)"
  task :nuke do
    envs.each do |env_file, env|
      db = Sequel.connect(env["DATABASE_URL"])
      db.tables.each do |table|
        db.run(%{DROP TABLE "#{table}"})
      end
      puts "Nuked `#{name_from_uri(env["DATABASE_URL"])}`"
    end
  end

  desc "Reset the database"
  task :reset => [:nuke, :migrate]

  desc "Create the database"
  task :create do
    db = Sequel.connect("postgres://localhost/postgres")
    envs.each do |env_file, env|
      exists = false
      name = name_from_uri(env["DATABASE_URL"])
      begin
        db.run(%{CREATE DATABASE "#{name}"})
      rescue Sequel::DatabaseError
        raise unless $!.message =~ /already exists/
        exists = true
      end
      puts "Created `#{name}`" if !exists
    end
  end

  desc "Drop the database"
  task :drop do
    db = Sequel.connect("postgres://localhost/postgres")
    envs.each do |env_file, env|
      name = name_from_uri(env["DATABASE_URL"])
      db.run(%{DROP DATABASE IF EXISTS "#{name}"})
      puts "Dropped `#{name}`"
    end
  end

  namespace :schema do
    desc "Load the database schema"
    task :load do
      schema = File.read("./db/schema.sql")
      envs.each do |env_file, env|
        db = Sequel.connect(env["DATABASE_URL"])
        db.run(schema)
        puts "Loaded `#{name_from_uri(env["DATABASE_URL"])}`"
      end
    end

    desc "Dump the database schema"
    task :dump do
      env_file, env = envs.first
      `pg_dump -i -s -x -O -f ./db/schema.sql #{env["DATABASE_URL"]}`
      puts "Dumped `#{name_from_uri(env["DATABASE_URL"])}` to db/schema.sql"
    end

    desc "Merges migrations into schema and removes them"
    task :merge => ["db:setup", "db:schema:load", "db:migrate", "db:schema:dump"] do
      FileUtils.rm Dir["./db/migrate/*.rb"]
      puts "Removed migrations"
    end
  end

  desc "Setup the database"
  task :setup => [:drop, :create]

  private

  def envs
    %w(.env .env.test).map { |env_file|
      env_path = "./#{env_file}"
      if File.exists?(env_path)
        [env_file, Pliny::Utils.parse_env(env_path)]
      else
        nil
      end
    }.compact
  end

  def name_from_uri(uri)
    URI.parse(uri).path[1..-1]
  end
end
