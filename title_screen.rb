class TitleScreen < AbstractScreen
  def initialize
    super
    add title = Label.new(10, 10, 'OckiDeux', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    add @word = Label.new(320, 200, '', :color=>Colors::HEADER, :height=>36)
    
    add timer = Timer.new(4000){|ticks|
      case ticks % 8
        when 0:         message "Make Words Into New Words"
        when 1:         message "Start with Grass"
                        word "Grass"
        when 2:         message "Replace the r with l"
                        word "Glass"
        when 3:         message "Remove the G"
                        word "Lass"
        when 4:         message "Replace the s with t"  
                        word "Last"
        when 5:         message "Swap the L and s"  
                        word "Salt"
        when 6:         message "Add an S"  
                        word "Salts"
        when 7:         message "That's all there is to it"
                        word ""
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
    
    add Button.new(10, height - 32, "Quit"){
      window.close
    }
  end
    
  def button_down(id)
    case id
    when Gosu::KbEscape:  window.close
    when Gosu::KbQ:       window.close
    end
  end
  
  def message(text, options={})
    label = Label.new(@word.left, @word.top - @word.height * 1.2, text)
    Move.insert(label, :to=>[label.x, -label.height], :delay=>3000, :in=>1000, :mode=>:ease_in_quad, :after=>lambda{remove label})
    Fade[label, {:to=>:out, :delay=>3000, :mode=>:ease_in_quad}]
  end
  
  def word(text)
    Fade[@word, {
      :to=>:out, :in=>500, :delay=>1000,
      :after=>lambda{@word.text = text; Fade[@word, {:to=>:in}]}
    }]
  end
end
