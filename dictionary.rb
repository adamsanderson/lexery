class Dictionary
  def initialize(db_path)
    @db = Sequel.sqlite(db_path)
    @words = @db[:words]
  end
  
  def valid_word?(word)
    @words.filter(:word=>word.downcase).count == 1
  end
  
  def pick(length=5)
    @words.filter("length(word) = #{length}").all.first
  end
end