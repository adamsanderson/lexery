class Transition
  def initialize(duration, start_value, end_value, options={}, &action)
    @duration = duration.to_f
    @start_value = start_value
    @change = compute_change(start_value, end_value)
    @options = options
    
    @action = action
    
    delay = options[:delay] || 0
    
    start
    @starts = Gosu::milliseconds + delay
  end
  
  def start
    @options[:start].call if @options[:start]
  end
  
  def finish
    @options[:finish].call if @options[:finish]
    Game.state.remove self
  end
  
  def tweening_function
    return @function if @function
    
    if @options[:mode].is_a? Symbol
      @function = TWEEN_FUNCTIONS[@options[:mode]]
    else
      @function = @options[:mode] || TWEEN_FUNCTIONS.default
    end

    @function
  end
  
  def compute_change(start_value, end_value)
    start_value.to_f - end_value.to_f
  end
  
  def update
    t =  (Gosu::milliseconds - @starts)
    
    if t >= @duration
      finish
    elsif t >= 0
      apply(t)
    end
  end
  
  def apply(t)
    @action.call(tweening_function[t, @start_value, @change, @duration])
  end
  
  # Tweening functions; as per Robert Penner
  #  http://www.robertpenner.com/easing/penner_chapter7_tweening.pdf
  # t: time
  # b: beginning
  # c: change
  # d: duration
  TWEEN_FUNCTIONS={
    :linear_tween =>  lambda{|t, b, c, d| c*(t/d) + b},
    :ease_in_quad =>  lambda{|t, b, c, d| c*(t/=d)*t + b},
    :ease_out_quad => lambda{|t, b, c, d| c * (t/=d)*(t-2)*-1 + b},
    :ease_in_quart => lambda{|t, b, c, d| c * ((t/d) ** 4) + b},
    :ease_out_quart =>lambda{|t, b, c, d| c * ((t/d-1) ** 4)*-1 -1 + b},
    :ease_in_sine =>  lambda{|t, b, c, d| c * (1 - Math.cos(t/d * (Math::PI/2))) + b},
    :ease_out_sine => lambda{|t, b, c, d| c * Math.sin(t/d * (Math::PI/2)) + b}
  }
  TWEEN_FUNCTIONS.default = TWEEN_FUNCTIONS[:linear_tween]
end