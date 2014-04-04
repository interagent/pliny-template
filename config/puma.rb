require "./config/config"

environment Config.rack_env
port Config.port
quiet
threads Config.puma_min_threads.to_i, Config.puma_max_threads.to_i
workers Config.puma_workers.to_i

on_worker_boot do
  # force Sequel's thread pool to be refreshed
  Sequel::DATABASES.each { |db| db.disconnect }
end

preload_app!
Thread.abort_on_exception = true
