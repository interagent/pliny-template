require "uri"

namespace :db do
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)

    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(Sequel::Model.db, "./db/migrate")
    puts "Migrated to the latest"
  end

  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)

    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(Sequel::Model.db, "./db/migrate", -1)
    puts "Rolled back."
  end

  desc "Nuke the database (drop all tables)"
  task :nuke, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    Sequel::Model.db.tables.each do |table|
      Sequel::Model.db.run("DROP TABLE #{table}")
    end
    puts "Nuked database"
  end

  desc "Create the database"
  task :create, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    name = URI.parse(uri).path[1..-1]
    Sequel::Model.db.run("CREATE DATABASE #{name}")
    puts "Database created"
  end

  desc "Drop the database"
  task :drop, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    name = URI.parse(uri).path[1..-1]
    Sequel::Model.db.run("DROP DATABASE IF EXISTS #{name}")
    puts "Database dropped"
  end

  desc "Load the database schema"
  task :load_schema, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    schema = File.read("./db/schema.sql")
    Sequel::Model.db.run(schema)
    puts "Loaded schema"
  end

  desc "Dump the database schema"
  task :dump_schema, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    `pg_dump -i -s -x -O -f ./db/schema.sql #{ENV["DATABASE_URL"]}`
    puts "Dumped schema"
  end

  desc "Reset the database"
  task :reset, [:env] => [:nuke, :migrate]
end
