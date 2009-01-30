class Game < ExuberantGame
  class << self
    def options_set
      @options_set ||= 'short game'
    end
  
    def all_options
      @options ||= YAML.load_file(File.join(GAME_ROOT, 'options.yml'))
    end
  
    def options
      all_options[options_set]
    end
  
    def db
      unless @db
        db_path = File.join(GAME_ROOT, 'game.db')
        new_db = !File.exists?(db_path)
        @db = Sequel.sqlite(db_path)
      
        if new_db
          Round.create_table
        end
      
        wordlist = File.join(GAME_ROOT, 'wordlists', 'words.db')
        @db << "attach '#{wordlist}' as wordlist"
      end
      @db
    end
  end
end