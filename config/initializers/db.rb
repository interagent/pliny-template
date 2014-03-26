abort("Missing DATABASE_URL") unless ENV["DATABASE_URL"]
DB = Sequel.connect(ENV["DATABASE_URL"])
