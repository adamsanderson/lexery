class Word < Sequel::Model
  set_schema do
    primary_key :id
    string :word, :unique=>true
  end
  
  class << self
    def pick(length=5)
      record = filter('length(word)'.lit=>length).order('random()'.lit).limit(1).first
      record.word
    end
  
    def valid_word?(word)
      filter(:word=>word.downcase).count == 1
    end
  end
  
end