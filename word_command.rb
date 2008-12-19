class WordCommand
  attr_reader :base_word
  attr_reader :word
  
  def initialize(word)
    @base_word = word
    @word = word
  end
  
  def describe
    "'#{@base_word}' to '#{@word}'"
  end
end