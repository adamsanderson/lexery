class StatsScreen < AbstractScreen
  def initialize
    super
    add title = Label.new(10, 10, 'Lexery Stats', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    labels = []
    Game.all_options.each_with_index{|option, i|
      key = option.first
      y = 128+i*96
      add label = Label.new(320, y, key.capitalize)
      games = Game.score_board.rounds(key)
      count = games.length
      
      if count > 0
        scores = games.select{|g| g.score > 0}.map{|g| g.score}
        average = scores.inject{|m,v| m+v} / scores.length.to_f # TODO: need some stats helpers
        best_round = games.sort_by{|g| [-g.score, -g.started.to_i]}.first
        
        add label = Label.new(340, y+36, "Rounds Played", :height=>18)
        add label = Label.new(480, y+36, count,           :height=>18)
        add label = Label.new(340, y+50, "Average Score", :height=>18)
        add label = Label.new(480, y+50, format('%.2f',average),         :height=>18)
        add label = Label.new(340, y+66, "Best Round",    :height=>18)
        add label = Label.new(480, y+66, "'#{best_round.initial_word}' #{best_round.score}", :height=>18)
      else
        add label = Label.new(340, y+36, "No games played yet", :height=>18)
      end
      labels << label
    }
    
    add Button.new(10, height - 32, "Back"){
      window.next_state = TitleScreen.new
    }
  end
  
  def button_down(id)
    super
    
    case id
    when Gosu::KbEscape then  
      window.next_state = TitleScreen.new
    end
  end
  
end