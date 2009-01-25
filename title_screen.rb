class TitleScreen < AbstractScreen
  def initialize
    super
    add title = Label.new(10, 10, 'OckiDeux', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    add @word = Label.new(320, 220, 'Word', :color=>Colors::HEADER, :height=>36)
    
    add timer = Timer.new(3000){|ticks|
      case ticks % 12
        when 0:         message "Make Words Into New Words"
                        word "Grass"
        when 2:         message "Replace the r with l"
                        word "Glass"
        when 4:         message "Remove the G"
                        word "Lass"
        when 6:         message "Replace the s with t"  
                        word "Last"
        when 8:         message "Swap the L and s"  
                        word "Salt"
        when 10:        message "Add an S"  
                        word "Salts"
      end
    }
    timer.start
    
    start_buttons = []
    Game.all_options.each_with_index{|option, i|
      key = option.first
      add button = Button.new(320, 256+i*42, key.capitalize){
        Game.options_set = key
        window.next_state = GameScreen.new
      }
      start_buttons << button
    }
    
    add Button.new(start_buttons.last.left, start_buttons.last.bottom + 32, "Statistics"){
      window.next_state = StatsScreen.new
    }
  end
    
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.close
    when Gosu::KbQ:       window.close
    end
  end
  
  def message(text, options={})
    add m = FadingMessage.new(@word.left, @word.top - @word.height * 1.2, text, {:mode=>:ease_in_quad}.merge(options))
  end
  
  def word(text)
    @word.text = text
  end
end
