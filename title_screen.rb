class TitleScreen < AbstractScreen
  def initialize
    super
    add title = Label.new(10, 10, 'OckiDeux', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    rules = [
      "The goal of this game is to make chains of words",
      "You may make one change to each word to get a new word",
      "You can insert, remove, or replace a letter",
      "If you replace a letter, you may not replace the same letter in the next move",
      "You are allowed a limited number of imaginary words to help you get to new words.",
      "One last rule, once you make a word, you cannot use it again.",
      "",
      "Click to begin!",
      "",
      "More to come, no seriously, ask me in a week or so!"
    ]
    
    rules.each_with_index{|r,i| add Label.new(32, title.bottom + (i+2) * (14), r, :height=>16) }
  end
    
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.close
    when Gosu::KbQ:       window.close
    else                  window.next_state = GameScreen.new()
    end
  end
end
