class WordCommand
  attr_reader :base_word
  attr_reader :word
  
  def initialize(word)
    @base_word = word.clone
    @word = word.clone
  end
  
  def describe
    "'#{@base_word}' to '#{@word}'"
  end
end