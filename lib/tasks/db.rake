require "uri"
require "sequel"
require "sequel/extensions/migration"

require_relative "../../vendor/pliny/lib/pliny/utils"

namespace :db do
  desc "Run database migrations"
  task :migrate do
    next if Dir["./db/migrate/*.rb"].empty?
    envs.each do |env_file, env|
      db = Sequel.connect(env["DATABASE_URL"])
      Sequel::Migrator.apply(db, "./db/migrate")
    end
    puts "Migrated to the latest"
  end

  desc "Rollback the database"
  task :rollback do
    next if Dir["./db/migrate/*.rb"].empty?
    envs.each do |env_file, env|
      db = Sequel.connect(env["DATABASE_URL"])
      Sequel::Migrator.apply(db, "./db/migrate", -1)
    end
    puts "Rolled back."
  end

  desc "Nuke the database (drop all tables)"
  task :nuke do
    envs.each do |env_file, env|
      db = Sequel.connect(env["DATABASE_URL"])
      db.tables.each do |table|
        db.run(%{DROP TABLE "#{table}"})
      end
    end
    puts "Nuked database"
  end

  desc "Reset the database"
  task :reset, [:env] => [:nuke, :migrate]

  desc "Create the database"
  task :create do
    db = Sequel.connect("postgres://localhost/postgres")
    envs.each do |env_file, env|
      begin
        name = URI.parse(env["DATABASE_URL"]).path[1..-1]
        db.run(%{CREATE DATABASE "#{name}"})
      rescue Sequel::DatabaseError
        raise unless $!.message =~ /already exists/
      end
    end
    puts "Database created"
  end

  desc "Drop the database"
  task :drop do
    db = Sequel.connect("postgres://localhost/postgres")
    envs.each do |env_file, env|
      name = URI.parse(env["DATABASE_URL"]).path[1..-1]
      db.run(%{DROP DATABASE IF EXISTS "#{name}"})
    end
    puts "Database dropped"
  end

  namespace :schema do
    desc "Load the database schema"
    task :load do
      schema = File.read("./db/schema.sql")
      envs.each do |env_file, env|
        db = Sequel.connect(env["DATABASE_URL"])
        db.run(schema)
      end
      puts "Loaded schema"
    end

    desc "Dump the database schema"
    task :dump do
      env_file, env = envs.first
      `pg_dump -i -s -x -O -f ./db/schema.sql #{env["DATABASE_URL"]}`
      puts "Dumped schema"
    end
  end

  desc "Setup the database"
  task :setup, [:env] => [:drop, :create]

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
end
