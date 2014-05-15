module Initializer
  def self.run
    require_config
    initialize_database
    require_lib
    require_initializers
  end

  def self.require_config
    require! "config/config.rb"
  end

  def self.initialize_database
    Sequel.connect(Config.database_url, max_connections: Config.db_pool)
  end

  def self.require_lib
    require! %w(
      lib/endpoints/base
      lib/endpoints/**/*.rb
      lib/mediators/base
      lib/mediators/**/*.rb
      lib/models/**/*.rb
      lib/routes
    )
  end

  def self.require_initializers
    Pliny::Utils.require_glob("#{root}/config/initializers/*.rb")
  end

  def self.require!(globs)
    globs = [globs] unless globs.is_a?(Array)
    globs.each do |f|
      Pliny::Utils.require_glob("#{root}/#{f}")
    end
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

Initializer.run
