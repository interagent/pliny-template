Dir[File.expand_path("../tasks", __FILE__) + "/*.rake"].sort.each do |task|
  load(task)
end
