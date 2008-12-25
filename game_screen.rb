class GameScreen < AbstractScreen
  def initialize(word)
    super()
    
    @rules = GameRules.new
    @dictionary = Dictionary.new(Game.options['dictionary'])
    
    @status = Label.new(10, self.height - 32, "current word: #{word}", :height=>32)
    
    @word_control = WordControl.new(320, 256, word)
    Game.window.text_input = @word_control

    @reset_button = Button.new(@word_control.left, @word_control.bottom + 10, 'reset') do
      @word_control.reset
    end
    
    @ok_button = Button.new(@reset_button.right + 12, @word_control.bottom + 10, 'ok')
    
  end
  
  def draw
    super
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
    @word_control.draw
    @reset_button.draw
    @ok_button.draw
    @status.draw
  end
  
  def update
    # todo: make this into an event/listener
    # todo: make this into the rules object
    unless @last_word == @word_control.text 
      @valid_transition = @rules.valid_transition? @word_control.word, @word_control.text
      @valid_word = @dictionary.valid_word? @word_control.text
      @last_word = @word_control.text
      @word_control.valid = @valid_transition && @valid_word
      
      @status.text = if @word_control.word == @word_control.text
        "Add, remove, or change one letter to create a new word"
      elsif !@valid_transition
        "You may only add, remove, or change one letter"
      elsif !@valid_word
        "'#{@word_control.text}' is not in the dictionary"
      else
        "Click 'ok', or hit 'enter' to use this word"
      end
    end
    
    @word_control.update
    @reset_button.update
    @ok_button.update
    @status.update
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.next_state = TitleScreen.new
    end
  end
  
  def button_up(id)
    @reset_button.button_up(id)
    @ok_button.button_up(id)
  end
end
