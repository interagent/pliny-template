require "sequel"
require "sequel/extensions/migration"

module Pliny::Commands
  class Migrator
    include Common

    def self.run(args, stream=$stdout)
      new(args).run!
    end

    def initialize(args={}, stream=$stdout)
      @args = args
      @stream = stream
    end

    def run!
      chroot!
      envs.each do |env_file, env|
        display "Migrating #{env_file}"
        db = Sequel.connect(env["DATABASE_URL"])
        Sequel::Migrator.apply(db, migrations_path)
      end
    end

    private

    attr_accessor :args, :stream

    def migrations_path
      File.expand_path("db/migrate", Dir.pwd)
    end
  end
end
