class TitleScreen < AbstractScreen
  def initialize
    super
    add title = Label.new(10, 10, 'OckiDeux', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    add timer = Timer.new(3000){|ticks|
      case ticks % 12
        when 0:         message "Make Words Into New Words "
        when 1:         message "Grass"
        when 2:         message "Replace the r with l"
        when 3:         message "Glass"
        when 4:         message "Remove the G"
        when 5:         message "Lass"
        when 6:         message "Replace the s with t"  
        when 7:         message "Last"
        when 8:         message "Swap the L and s"  
        when 9:         message "Salt"
        when 10:        message "Add an S"  
        when 11:        message "Salts"
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
    add m = FadingMessage.new(320, 224, text, {:mode=>:ease_in_quad}.merge(options))
  end
end
