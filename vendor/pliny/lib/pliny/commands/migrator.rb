require "sequel"
require "sequel/extensions/migration"

module Pliny::Commands
  class Migrator
    def self.run(args, stream=$stdout)
      new(args).run!
    end

    def initialize(args={}, stream=$stdout)
      @args = args
      @stream = stream
    end

    def run!
      root = find_root
      display "Root is #{root}"
      if no_migrations?
        display "No pending migrations"
      else
        envs.each do |env_file, env|
          display "Migrating #{env_file}"
          db = Sequel.connect(env["DATABASE_URL"])
          Sequel::Migrator.apply(db, migrations_path)
        end
      end
    end

    private

    attr_accessor :args, :stream

    def display(msg)
      stream.puts msg
    end

    def panic(msg)
      $stderr.puts msg
      exit 1
    end

    def envs
      %w(.env .env.test).map { |env_file|
        env_path = File.expand_path(env_file, Dir.pwd)
        if File.exists?(env_path)
          [env_file, Pliny::Utils.parse_env(env_path)]
        else
          nil
        end
      }.compact
    end

    def find_root
      loop do
      p Dir.pwd
        if File.exists?(File.expand_path(".env", Dir.pwd))
          return Dir.pwd
        else
          Dir.chdir("..")
        end
        if Pathname.new(Dir.pwd).root?
          panic "No project found"
        end
      end
    end

    def migrations_path
      File.expand_path("db/migrate", Dir.pwd)
    end

    def no_migrations?
      Dir["#{migrations_path}/*.rb"].empty?
    end
  end
end
