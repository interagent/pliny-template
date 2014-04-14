# Sequel requires a DB connection before any models can successfully be loaded
# so we initialize them "late" in a separate load file.
Pliny::Utils.require_relative_glob("#{App.root}/lib/models/**/*.rb")
