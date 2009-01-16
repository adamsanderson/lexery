class Transition
  def initialize(duration, start_value, end_value, options={}, &action)
    @duration = duration.to_f
    @start_value = start_value.to_f
    @change = @end_value.to_f - @start_value.to_f
    
    @options = options
    
    if options[:mode].is_a? Symbol
      @function = TWEEN_FUNCTIONS[options[:mode]]
    else
      @function = options[:mode] || TWEEN_FUNCTIONS[:linear_tween]
    end
    
    @options[:start].call if @options[:start]
    @action = action
    
    @started = Gosu::milliseconds
  end
  
  def update
    t =  (Gosu::milliseconds - @started)
    
    if t >= @duration
      @options[:finish].call if @options[:finish]
      Game.state.remove self
    else
      @action.call(@function[t, @start_value, @change, @duration])
    end
  end
  
  # Tweening functions; as per Robert Penner
  #  http://www.robertpenner.com/easing/penner_chapter7_tweening.pdf
  # t: time
  # b: beginning
  # c: change
  # d: duration
  TWEEN_FUNCTIONS={
    :linear_tween =>  lambda{|t, b, c, d| c*t/d + b},
    :ease_in_quad =>  lambda{|t, b, c, d| c*(t/=d)*t + b},
    :ease_out_quad => lambda{|t, b, c, d| -c * (t/=d)*(t-2) + b},
    :ease_in_quart => lambda{|t, b, c, d| c * ((t/d) ** 4) + b},
    :ease_out_quart =>lambda{|t, b, c, d| -c * ((t/d-1) ** 4) -1 + b},
    :ease_in_sine =>  lambda{|t, b, c, d| c * (1 - Math.cos(t/d * (Math::PI/2))) + b},
    :ease_out_sine => lambda{|t, b, c, d| c * Math.sin(t/d * (Math::PI/2)) + b}
  }
end