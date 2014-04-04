on_worker_boot do
  # force Sequel's thread pool to be refreshed
  Sequel::DATABASES.each { |db| db.disconnect }
end
