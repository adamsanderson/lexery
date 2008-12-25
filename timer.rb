class Timer < Label
  attr_reader :remaining
  
  def initialize(x,y, duration, options={})
    super(x,y, duration.to_s, options)
    @duration = duration
    @remaining = duration
  end
  
  def start
    @started = Gosu::milliseconds
  end
  
  def update
    if @started
      seconds = (Gosu::milliseconds - @started) / 1000
      @remaining = @duration - seconds
      self.text = remaining.to_s
      if @remaining < 5
        @color = Gosu::Color.new(128, 255,0,0)
      end
    end
  end
  
end