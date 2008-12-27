class GameOverScreen < AbstractScreen
  def initialize(round)
    super()
    @title_font = Game.load_font 'Helvetica', 48
    
    @score = Label.new(320, 256, "'#{round.initial_word}' #{round.score} words")
    @words = round.words.split(',')
    
    @new_game = Button.new(320, @score.bottom + 4, "New Game") do
      window.next_state = GameScreen.new()
    end
    
    @replay_game = Button.new(320, @new_game.bottom + 4, "Try Again") do
      window.next_state = GameScreen.new(round.initial_word)
    end
  end

  def draw
    super
    @title_font.draw_rel("OckiDeux Game Over", Game.window.width/2, 10, Layers::UI, 0.5, 0, 1, 1, 0x666666FF, :default)
    
    @score.draw
    @new_game.draw
    @replay_game.draw
  end
  
  def update
    @score.update
    @new_game.update
    @replay_game.update
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape then  
      window.next_state = TitleScreen.new
    end
  end
  
  def button_up(id)
    @new_game.button_up(id)
    @replay_game.button_up(id)
  end
end