require "erb"
require "fileutils"
require "ostruct"

module Pliny
  class Generator
    attr_accessor :type

    def self.run(args)
      new(args).run!
    end

    def initialize(args)
      @type = args.first
    end

    def run!
      case @type
      when "model"
        name = ARGV[1] || abort("Missing model name")
        create_model(name)
      when "migration"
        name = ARGV[1] || abort("Missing migration name")
        create_migration(name)
      else
        abort("Don't know how to generate #{@type}.")
      end
    end

    def create_model(name)
      class_name = name.capitalize
      file_name  = name.downcase

      model = "./lib/models/#{file_name}.rb"
      render_template("model.erb", model, class_name: class_name)
      puts "created model file #{model}"

      migration = "./db/migrate/#{Time.now.to_i}_create_#{file_name}.rb"
      render_template("model_migration.erb", migration,
        table_name: "#{file_name}s")
      puts "created migration #{migration}"
    end

    def create_migration(name)
      file_name = name.downcase
      migration = "./db/migrate/#{Time.now.to_i}_#{file_name}.rb"
      render_template("migration.erb", migration)
      puts "created migration #{migration}"
    end

    def render_template(template_file, destination_path, vars={})
      template_path = "./vendor/pliny/templates/#{template_file}"
      template = ERB.new(File.read(template_path))
      FileUtils.mkdir_p(File.dirname(destination_path))
      File.open(destination_path, "w") do |f|
        context = OpenStruct.new(vars)
        f.puts template.result(context.instance_eval { binding })
      end
    end
  end
end
