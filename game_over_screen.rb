class GameOverScreen < AbstractScreen
  def initialize(round)
    super()
    @title_font = Game.load_font 'Helvetica', 48
    
    add @score = Label.new(320, 256, "'#{round.initial_word}' #{round.score} words")
    add @words = round.words.split(',')
    
    add @new_game = Button.new(320, @score.bottom + 4, "New Game"){
      window.next_state = GameScreen.new()
    }
    
    add @replay_game = Button.new(320, @new_game.bottom + 4, "Try Again"){
      window.next_state = GameScreen.new(round.initial_word)
    }
  end

  def draw
    super
    @title_font.draw_rel("OckiDeux Game Over", Game.window.width/2, 10, Layers::UI, 0.5, 0, 1, 1, 0x666666FF, :default)
  end
  
  def update
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape then  
      window.next_state = TitleScreen.new
    end
  end
end