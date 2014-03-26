module Pliny
  def self.initialize!
    require_relative_glob("initializers/*.rb")
  end

  # Requires an entire directory of source files in a stable way so that file
  # hierarchy is respected for load order.
  def self.require_relative_glob(relative_path)
    files = Dir["#{Pliny.root}/#{relative_path}"].sort_by do |file|
      [file.count("/"), file]
    end

    files.each do |file|
      require file
    end
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

require_relative "pliny/endpoints/base"

Pliny.require_relative_glob("lib/pliny/endpoints/**/*.rb")

require_relative "pliny/main"
