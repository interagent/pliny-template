require "pliny/tasks"

# Add your rake tasks to lib/tasks!
Dir["./lib/tasks/*.rake"].each { |task| load task }

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
