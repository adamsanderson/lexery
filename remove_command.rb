class RemoveCommand < WordCommand
    
  def initialize(word, index)
    super(word)
    @word[index] = ''
  end
  
end