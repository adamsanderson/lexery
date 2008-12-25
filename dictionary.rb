class Dictionary
  def initialize(db_path)
    @db = Sequel.sqlite(db_path)
    @words = @db[:words]
  end
  
  def valid_word?(word)
    @words.filter(:word=>word.downcase).count == 1
  end
end