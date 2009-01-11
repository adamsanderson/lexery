class StatsScreen < AbstractScreen
  def initialize
    super
    add title = Label.new(10, 10, 'OckiDeux Stats', :color=>Colors::HEADER, :height=>48)
    title.x = Game.window.width/2 - title.width/2
    
    labels = []
    Game.all_options.each_with_index{|option, i|
      key = option.first
      y = 128+i*96
      add label = Label.new(320, y, key.capitalize)
      games = Game.db[:rounds].filter(:options_set=>key)
      count = games.count
      
      if count > 0
        average = games.filter('score > 0').avg :score
        best_round = games.order(:score.desc, :started.desc).first
        
        add label = Label.new(340, y+36, "Rounds Played", :height=>18)
        add label = Label.new(480, y+36, count,           :height=>18)
        add label = Label.new(340, y+50, "Average Score", :height=>18)
        add label = Label.new(480, y+50, average,         :height=>18)
        add label = Label.new(340, y+66, "Best Round",    :height=>18)
        add label = Label.new(480, y+66, "'#{best_round[:initial_word]}' #{best_round[:score]}", :height=>18)
      end
      labels << label
    }
    
    add Button.new(340, labels.last.bottom + 32, "Back"){
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