class GameOverScreen < AbstractScreen
  def initialize(initial_word, history)
    super()
    @title_font = Game.load_font 'Helvetica', 48
    
    @score = Label.new(320, 256-32, "'#{initial_word}' #{history.length} words")
    
    @new_game = Button.new(320, 256, "New Game") do
      window.next_state = GameScreen.new()
    end
    
    @replay_game = Button.new(320, @new_game.bottom + 4, "Try Again") do
      window.next_state = GameScreen.new(initial_word)
    end
  end

  def draw
    super
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
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