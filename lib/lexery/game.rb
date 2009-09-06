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
    
    def dictionary
      @dictionary ||= begin
        path = File.join(GAME_ROOT, 'wordlists', 'words.set')
        Dictionary.new(path)
      end
    end
    
    def score_board
      @score_board ||= begin
        path = File.join(GAME_ROOT, 'scores')
        ScoreBoard.new(path)
      end
    end
    
  end
end