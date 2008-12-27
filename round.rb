class Round < Sequel::Model
  set_schema do
    primary_key :id
    datetime    :started
    integer     :score
    integer     :duration
    string      :initial_word
    text        :words # comma separated, lets be lazy
  end
end