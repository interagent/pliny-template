environment (ENV["RACK_ENV"] || "development")
port ENV["PORT"] || 5000
quiet
threads Integer(ENV['PUMA_MIN_THREADS']  || 1),
  Integer(ENV['PUMA_MAX_THREADS'] || 16)
workers Integer(ENV['PUMA_WORKERS'] || 3)

on_worker_boot do
  # force Sequel's thread pool to be refreshed
  Sequel::DATABASES.each { |db| db.disconnect }
end

preload_app!
Thread.abort_on_exception = true
