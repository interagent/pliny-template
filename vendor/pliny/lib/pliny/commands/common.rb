module Pliny::Commands
  module Common
    def chroot!
      loop do
        if File.exists?(File.expand_path(".env", Dir.pwd))
          break
        elsif File.exists?(File.expand_path(".env.test", Dir.pwd))
          break
        else
          Dir.chdir("..")
        end
        if Pathname.new(Dir.pwd).root?
          panic "No project found"
        end
      end
      display "Root is #{root}"
    end

    def display(msg)
      stream.puts msg
    end

    def envs
      %w(.env .env.test).map { |env_file|
        env_path = File.expand_path(env_file, root)
        if File.exists?(env_path)
          [env_file, Pliny::Utils.parse_env(env_path)]
        else
          nil
        end
      }.compact
    end

    def panic(msg)
      $stderr.puts msg
      exit 1
    end

    # Only returns root after #chroot has been called.
    def root
      Dir.pwd
    end
  end
end
