require "rake/testtask"

task :default => :test

Rake::TestTask.new do |task|
  task.libs << "lib"
  task.libs << "test"
  task.name = :test
  task.test_files = FileList["test/*_test.rb"]
end

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  require "./lib/pliny"
  Sequel.connect(ENV["DATABASE_URL"])
end

namespace :db do
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)

    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(Sequel::Model.db, "db/migrate")
    puts "Migrated to the latest"
  end

  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)

    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(Sequel::Model.db, "db/migrate", -1)
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

  desc "Reset the database"
  task :reset, [:env] => [:nuke, :migrate]
end
