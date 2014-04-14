require "erb"
require "fileutils"
require "ostruct"
require "active_support/inflector"

module Pliny::Commands
  class Generator
    def self.run(args, stream=$stdout)
      new(args).run!
    end

    def initialize(args={}, stream=$stdout)
      @args = args
      @stream = stream
    end

    def run!
      unless type
        raise "Missing type of object to generate"
      end
      unless name
        raise "Missing #{type} name"
      end

      case type
      when "endpoint"
        create_endpoint
      when "mediator"
        create_mediator
      when "migration"
        create_migration
      when "model"
        create_model
      else
        abort("Don't know how to generate '#{type}'.")
      end
    end

    private

    attr_accessor :args, :stream

    def type
      args.first
    end

    def name
      args[1]
    end

    def class_name
      name.camelize
    end

    def table_name
      name.tableize
    end

    def display(msg)
      stream.puts msg
    end

    def create_endpoint
      url_path   = "/" + name.gsub(/_/, '-')

      endpoint = "./lib/endpoints/#{name}.rb"
      render_template("endpoint.erb", endpoint, {
        class_name: class_name,
        url_path:   url_path,
      })
      display "created endpoint file #{endpoint}"
      display "add the following to lib/routes.rb:"
      display "  use Endpoints::#{class_name}"

      test = "./test/endpoints/#{name}_test.rb"
      render_template("endpoint_test.erb", test, {
        class_name: class_name,
        url_path:   url_path,
      })
      display "created test #{test}"
    end

    def create_mediator
      base_mediator = "./lib/mediators/base.rb"
      unless File.exists?(base_mediator)
        render_template("base_mediator.erb", base_mediator)
        display "created base mediator #{base_mediator}"
      end
      mediator = "./lib/mediators/#{name}.rb"
      render_template("mediator.erb", mediator, class_name: class_name)
      display "created mediator file #{mediator}"

      test = "./test/mediators/#{name}_test.rb"
      render_template("mediator_test.erb", test, class_name: class_name)
      display "created test #{test}"
    end

    def create_migration
      migration = "./db/migrate/#{Time.now.to_i}_#{name}.rb"
      render_template("migration.erb", migration)
      display "created migration #{migration}"
    end

    def create_model
      model = "./lib/models/#{name}.rb"
      render_template("model.erb", model, class_name: class_name)
      display "created model file #{model}"

      migration = "./db/migrate/#{Time.now.to_i}_create_#{table_name}.rb"
      render_template("model_migration.erb", migration,
        table_name: table_name)
      display "created migration #{migration}"

      test = "./test/models/#{name}_test.rb"
      render_template("model_test.erb", test, class_name: class_name)
      display "created test #{test}"
    end

    def render_template(template_file, destination_path, vars={})
      template_path = File.dirname(__FILE__) + "/../templates/#{template_file}"
      template = ERB.new(File.read(template_path))
      FileUtils.mkdir_p(File.dirname(destination_path))
      File.open(destination_path, "w") do |f|
        context = OpenStruct.new(vars)
        f.puts template.result(context.instance_eval { binding })
      end
    end
  end
end
