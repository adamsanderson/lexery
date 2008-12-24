class ReplaceCommand < WordCommand
    
  def initialize(word, index, letter)
    super(word)
    
    @word[index] = letter
  end
  
end