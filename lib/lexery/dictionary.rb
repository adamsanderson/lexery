class Dictionary
  def initialize(path)
    @words = Marshal.load(path)
  end
  
  def valid_word?(word)
    @words.include? word.downcase
  end
  
  def pick(length=5)
    candidates = @words.select{|w| w.length == length }
    candidates[ rand(candidates.length) ]
  end
end