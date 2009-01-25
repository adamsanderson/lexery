class Move
  class << self
    # Shorthand to create and start a move effect
    def [] object, options={}
      
      if options[:to]
        x,y = options[:to]
      elsif options[:by]
        x,y = options[:by]
        x += object.x
        y += object.y
      else raise ArgumentError,"must specify :to, or :by as an option"
      end
      
      duration = options[:in] || 1000
      
      self.new(object, x,y, duration, options)
    end
  end
  
  def initialize(object, dest_x,dest_y, duration=1000, options={})
    Game.state.add MultiTransition.new(duration, [object.x, object.y], [dest_x,dest_y], options ){|x,y|
      object.x, object.y = x,y
    }
  end
end