class GameScreen < AbstractScreen
  def initialize(word=nil)
    super()
    
    @rules = GameRules.new
    @initial_word = word || Game.dictionary.pick
    @imaginary_count = Game.options['imaginary_words']
    @words = []
    @imaginary_words = []
    @duration = Game.options['duration']
    
    @click_sound  = Game.load_sound 'click.wav'
    @done_sound   = Game.load_sound 'bell.wav'
    @accept_sound = Game.load_sound 'chick.wav'
    
    add @status = Label.new(10, self.height - 32, "current word: #{word}", :height=>32)
    add score = Label.new(10, 10, :height=>16){"words: #{@words.length}"}
    add Label.new(10, score.bottom + 2, :height=>16){ "imaginary words remaining: #{@imaginary_count}" }
    
    if @duration
      add remaining_label = Label.new(self.width - 64, 10, @duration)
      add timer = Timer.new(1000){|ticks|
        remaining = @duration - ticks
        remaining_label.text = remaining
        case remaining
          when @duration: message "Welcome"
          when 10:        remaining_label.color = Colors::WARNING
          when 5:         message "5 seconds remaining", :color=>Colors::WARNING
                          @click_sound.play
          when 4,3,2,1:   message "#{remaining}",    :color=>Colors::WARNING
                          @click_sound.play
          when 0:         game_over
                          @done_sound.play
        end
      }
      timer.start
    end
    
    add @word_control = WordControl.new(320, 256, @initial_word)
    
    add @reset_button = Button.new(@word_control.left, @word_control.bottom + 10, 'reset'){
      @word_control.reset
    }
    
    add @ok_button = Button.new(@reset_button.right + 12, @word_control.bottom + 10, 'ok'){ accept }
    add @done_button = Button.new(width - 64, @status.top, 'done'){ game_over }

    @started = Time.now
  end
  
  def update
    super 
    
    # todo: make this into an event/listener
    # todo: make this into the rules object
    unless @last_word == @word_control.text 
      @valid_transition = @rules.valid_transition? @word_control.word, @word_control.text
      @valid_word = Game.dictionary.valid_word? @word_control.text
      @last_word = @word_control.text
      @changed_word = @word_control.word != @word_control.text
      @new_word = !@words.include?(@word_control.text)
      
      @word_control.valid = @valid_transition && @valid_word && @new_word && @changed_word
      @imaginary_word = @valid_transition && @new_word && @changed_word && !@valid_word
      
      @status.text = if !@changed_word
        "Add, remove, or change one letter to create a new word"
      elsif !@valid_transition
        "You may only add, remove, or change one letter"
      elsif !@valid_word
        "'#{@word_control.text}' is not in the dictionary"
      elsif !@new_word
        "'#{@word_control.text}' has already been used"
      else
        "Click 'ok', or hit 'enter' to use this word"
      end
      
    end
  end
  
  def accept
    if @word_control.valid || (@imaginary_word && @imaginary_count > 0)
      word = @word_control.text
      @accept_sound.play
      
      if @imaginary_word
        @imaginary_words << word
        @imaginary_count -= 1
      end
      
      @words << word
      message word, :color=>(@imaginary_word ? Gosu::Color.new(128, 255,0,0) : nil )
      @word_control.word = word
    else
      #@reject_sound.play
    end
  end
  
  def game_over
    score = [0, @words.length - @imaginary_words.length].max
    round = Round.new(
      :started         => @started,
      :initial_word    => @initial_word, 
      :words           => @words,
      :imaginary_words => @imaginary_words
    )
    
    Game.score_board.record(Game.options_set, round)
    window.next_state = GameOverScreen.new(round)
  end
  
  def button_down(id)
    super
    
    case id
    when Gosu::KbReturn, Gosu::KbEnter then
      accept
    when Gosu::KbTab then
      @word_control.reset
    when Gosu::KbEscape then  
      window.next_state = TitleScreen.new
    end
  end
  
  def message(text, options={})
    add m = FadingMessage.new(320, 224, text, options)
  end
end
