class GameScreen < AbstractScreen
  def initialize(word)
    super()
    @word = word
    @word_font = Game.load_font 'Helvetica', 48
    @info_font = Game.load_font 'Helvetica', 12
  end
  
  def draw
    super
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
    @word_font.draw_rel(@word, Game.window.width/2, 10, Layers::UI, 0.5, 0, 1, 1, 0x666666FF, :default)
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.next_state = TitleScreen.new
    when Gosu::KbQ:       window.close
    end
  end
end
