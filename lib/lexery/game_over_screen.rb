class GameOverScreen < AbstractScreen
  def initialize(round)
    super()

    words = round.words
    imaginary_words = round.imaginary_words
    
    add title = Label.new(10, 10, 'Game Over', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    add score = Label.new(320, 256, "'#{round.initial_word}' #{round.score} words")
    add timer = Timer.new(1000){|ticks|
      word = words[(ticks+1) % words.length]
      color = imaginary_words.include?(word) ? Colors::FADED_WARNING : Colors::FADED
      add FadingMessage.new(320, score.top-32, word, :color=>color)
    }
    
    add new_game = Button.new(score.left, score.bottom + 4, "New Game"){
      window.next_state = GameScreen.new()
    }
    
    add replay_game = Button.new(new_game.left, new_game.bottom + 4, "Try Again"){
      window.next_state = GameScreen.new(round.initial_word)
    }
    
    add Button.new(10, height - 32, "Back"){
      window.next_state = TitleScreen.new
    }
    
    timer.start
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape then  
      window.next_state = TitleScreen.new
    end
  end
end