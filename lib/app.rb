module App
  def self.initialize!
    Pliny::Utils.require_glob("#{App.root}/config/initializers/*.rb")
  end

  def self.require!(globs)
    globs.map { |f| App.root + "/" + f + ".rb" }.
      each { |f| Pliny::Utils.require_glob(f) }
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

App.require!([
  "config/config",
  "lib/endpoints/base",
  "lib/endpoints/**/*",
  "lib/mediators/base",
  "lib/mediators/**/*",
  "lib/routes",
])
