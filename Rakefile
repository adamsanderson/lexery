require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "lexery"
    s.summary = "An enteraining word game"
    s.description = <<-DESC
      An enteraining word game
    DESC
    s.email = "netghost@gmail.com"
    s.homepage = "http://github.com/adamsanderson/lexery"
    s.authors = ["Adam Sanderson"]
    s.has_rdoc = false
    s.files = FileList["[A-Z]*(\.+)?", "{lib}/**/*", "{fonts,images,sounds,wordlists,script}/*", "options.yml"]
    
    # Testing
    s.add_dependency 'gosu', '~> 0.7.14'
  end

rescue LoadError
  puts "Jeweler not available. Install it for jeweler-related tasks with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

task :default => :test