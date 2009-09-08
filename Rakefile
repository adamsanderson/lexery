require 'rake'
require 'set'

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

desc "Rebuilds all the wordlists"
task :wordlist do
  Dir['wordlists/*.txt'].each do |source|
    target = source.sub(/\.txt$/,'.set')
    puts "Indexing: #{source}"

    index = Set.new    
    open(source, 'r') do |io|
      io.each_line do |word|
        word = word.chomp.downcase
        index << word
      end
    end
    
    puts "Writing: #{target}"
    open(target,'w') do |io|
      Marshal.dump(index, io)
    end
    
  end
end

task :default => :test