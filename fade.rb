class Fade < MultiTransition
  class << self
    # Shorthand to create and start effect
    def [] object, options={}
      
      to = options[:to]
      if (to.is_a? Gosu::Color) || (to.is_a? Numeric)
        color = options[:to]
      elsif to == :in
        color = Gosu::Color.new(object.color.argb | 0xff000000)
      elsif to == :out
        color = Gosu::Color.new(object.color.argb & 0x00ffffff)
      else
        raise ArgumentError,"must specify a :to option"
      end
      
      duration = options[:in] || 1000
      
      Game.state.add self.new(object, color, duration, options)
    end
    
    def insert object, options={}
      options[:before] = lambda{ Game.state.add(object) }.compose(options[:before])
      self[object, options]
    end
    
    def remove object, options={}
      options[:after] = lambda{ Game.state.remove(object) }.compose(options[:after])
      self[object, options]
    end
  end
  
  def initialize(object, dest_color, duration=1000, options={})
    dest_color = Gosu::Color.new(dest_color) if dest_color.is_a? Numeric
    super(duration, object.color.argb_components, dest_color.argb_components, options ){|a,r,g,b|
      object.color = Gosu::Color.new(a.to_i,r.to_i,g.to_i,b.to_i)
    }
  end
end