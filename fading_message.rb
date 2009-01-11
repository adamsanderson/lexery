class FadingMessage < Label
  def initialize(x,y, text, options={})
    super(x,y, text, options)
    
    @start_y    = self.y
    @target_y   = 0 - self.height
    @base_color = self.color
    
    Game.state.add Effect.new(3000, 
      :mode=>:out, 
      :finish=>lambda{Game.state.remove self}
      ){|p|
        
        self.color = Gosu::Color.new(
          (255*p).to_i, 
          @base_color.red,
          @base_color.green,
          @base_color.blue
        )
        self.y = (@target_y..@start_y)[p]
    }
  end
end