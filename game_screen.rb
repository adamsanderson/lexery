class GameScreen < AbstractScreen
  def initialize(word)
    super()
    @word_control = WordControl.new(word)
  end
  
  def draw
    super
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
    @word_control.draw
  end
  
  def update
    @word_control.update
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.next_state = TitleScreen.new
    when Gosu::KbQ:       window.close
    end
  end
end
