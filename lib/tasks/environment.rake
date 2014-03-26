namespace :bundler do
  task :setup do
    require "rubygems"
    require "bundler/setup"
    Bundler.require
  end
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  require "./lib/app"
  Sequel.connect(ENV["DATABASE_URL"])
end
