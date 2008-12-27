class GameOverScreen < AbstractScreen
  def initialize(round)
    super()
    words = round.words.split(',')
    
    add title = Label.new(10, 10, 'Game Over', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    add score = Label.new(320, 256, "'#{round.initial_word}' #{round.score} words")
    add new_game = Button.new(score.left, score.bottom + 4, "New Game"){
      window.next_state = GameScreen.new()
    }
    
    add replay_game = Button.new(new_game.left, new_game.bottom + 4, "Try Again"){
      window.next_state = GameScreen.new(round.initial_word)
    }
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape then  
      window.next_state = TitleScreen.new
    end
  end
end