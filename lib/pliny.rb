module Pliny
  def self.require_relative_glob(relative_path)
    Dir[].each do |file|
      require "#{Pliny.root}/lib/pliny/#{relative_path}"
    end
  end

  def self.root
    @@root ||= File.expand_path("../../", __FILE__)
  end
end

require_relative "pliny/endpoints/base"

Pliny.require_relative_glob("pliny/endpoints/**/*.rb")

require_relative "pliny/main"
