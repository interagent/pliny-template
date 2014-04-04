threads 1, 16
workers 3

on_worker_boot do
  # force Sequel's thread pool to be refreshed
  Sequel::DATABASES.each { |db| db.disconnect }
end

preload_app!
Thread.abort_on_exception = true
