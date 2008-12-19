class SwapCommand < WordCommand
    
  def initialize(word, index_1, index_2)
    super(word)
    
    char_1 = @word.chars[index_1]
    char_2 = @word.chars[index_2]
    @word[index_1] = char_2
    @word[index_2] = char_1
  end
  
end