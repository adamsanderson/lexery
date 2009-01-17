class FadingMessage < Label
  def initialize(x,y, text, options={})
    super(x,y, text, options)
    
    @start_y    = self.y
    @target_y   = 0 - self.height
    @base_color = self.color
    
    Game.state.add MultiTransition.new(3000, [@start_y, 255], [@target_y, 0],
      :mode=>:linear_tween, 
      :finish=>lambda{Game.state.remove self}
      ){|y, alpha|
          self.color = Gosu::Color.new(
            alpha.to_i, 
            @base_color.red,
            @base_color.green,
            @base_color.blue
          )
        self.y = y
    }
  end
end