require 'rubygems'
require 'sequel'
require 'support'

list = ARGV.shift
db_file = list[/^([^\.]+)\..+$/,1] + '.db'

if File.exist? db_file
  puts "Deleting old database: #{db_file}"
  File.delete db_file
end

puts "Building database: #{db_file}"
DB = Sequel.sqlite(db_file)
Word.create_table!
insert = Word.dataset.prepare(:insert, :insert_with_word, :word=>:$word)

letter = ''

batch = []

open(list, 'r') do |io|
  io.each_line do |word|
    if word[0] != letter[0]
      print "#{word.get 0} "; STDOUT.flush
      letter = word.get 0
    end
    
    word = word.chomp.downcase
    insert.call(:word=>word)
  end
  puts "!"
end

puts "Indexing..."
Sequel::Schema::AlterTableGenerator.new(DB) do 
  add_index :word, :unique=>true
end

puts "Done"