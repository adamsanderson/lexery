class Timer
  include Publisher
  events :ticked
  attr_reader :ticks
  
  def initialize(period, &action)
    @period = period
    @ticks = nil
    subscribe(:ticked, self, &action) if block_given?
  end
  
  def start
    @started = Gosu::milliseconds
  end
  
  def stop
    @started = nil
  end
  
  def update
    if @started
      current_ticks = (Gosu::milliseconds - @started) / @period
      if !@ticks || current_ticks > @ticks
        @ticks = current_ticks
        fire_event :ticked, current_ticks
      end
    end
  end
  
end