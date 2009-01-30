class GameWindow < Gosu::Window
  attr_reader :state
  attr_writer :next_state
  
  def initialize()
    super(800, 600, false)
    Game.window = self
    
    @state = TitleScreen.new
    @fps = FpsCounter.new
  end
  
  def draw
    @state.draw
  end
  
  def update
    @fps.register_tick
    self.caption = "Lexery: #{@fps.fps} FPS"
        
    @state.update
    if @next_state then
      @state, @next_state = @next_state, nil
    end
  end
  
  def button_down(id)
    @state.button_down(id)
  end
  
  def button_up(id)
    @state.button_up(id)
  end
end
