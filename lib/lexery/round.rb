class Round
  attr_reader :started, :words, :imaginary_words
  def initialize(hash)
    @started          = hash[:started]
    @score            = hash[:score]
    @words            = hash[:words]
    @imaginary_words  = hash[:imaginary_words]
  end
  
  def score
    @words.length
  end
    
  def initial_word
    words.first
  end
end