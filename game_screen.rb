class GameScreen < AbstractScreen
  def initialize(word)
    super()
    @word_control = WordControl.new(word)
    @reset_button = Button.new(@word_control.left, @word_control.bottom + 10, 'reset') do
      @word_control.reset
    end
    
  end
  
  def draw
    super
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
    @word_control.draw
    @reset_button.draw
  end
  
  def update
    @word_control.update
    @reset_button.update
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.next_state = TitleScreen.new
    end
  end
  
  def button_up(id)
    @word_control.button_up(id)
    @reset_button.button_up(id)
  end
end
