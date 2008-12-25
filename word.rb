class Word < Sequel::Model
  set_schema do
    primary_key :id
    string :word, :unique=>true
    text :definition
  end
end