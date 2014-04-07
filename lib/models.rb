# Sequel requires a DB connection before any models can successfully be loaded
# so we initialize them "late" in a separate load file.
puts "loading models!!"
Pliny::Utils.require_relative_glob("lib/models/**/*.rb")
