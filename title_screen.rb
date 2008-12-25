class TitleScreen < AbstractScreen
  def initialize
    super
    @title_font = Game.load_font 'Helvetica', 48
    @info_font = Game.load_font 'Helvetica', 12
  end
  
  def draw
    super
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
    @title_font.draw_rel("OckiDeux", Game.window.width/2, 10, Layers::UI, 0.5, 0, 1, 1, 0x666666FF, :default)
    
    rules = [
      "The goal of this game is to make chains of words",
      "You may make one change to each word to get a new word",
      "You can insert, remove, or replace a letter",
      "If you replace a letter, you may not replace the same letter in the next move",
      "You are allowed a limited number of imaginary words to help you get to new words.",
      "One last rule, once you make a word, you cannot use it again.",
      "",
      "Click to begin!"
    ]
    
    rules.each_with_index do |rule, i|
      @info_font.draw(rule, 32, 68 + (i+1) * (14), Layers::UI, 1,1, 0x66666666, :default)
    end
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.close
    when Gosu::KbQ:       window.close
    else                  window.next_state = GameScreen.new()
    end
  end
end
