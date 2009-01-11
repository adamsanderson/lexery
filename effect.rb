class Effect
  def initialize(duration, options={}, &action)
    @duration = duration
    @p = 0
    @options = options
    if options[:mode].is_a? Symbol
      @function = FUNCTIONS[options[:mode]]
    else
      @function = options[:mode] || FUNCTIONS[:in]
    end
    
    @options[:start].call if @options[:start]
    @action = action
    @started = Gosu::milliseconds
  end
  
  def update
    @p = (Gosu::milliseconds - @started)/(@duration.to_f)
    
    if @p >= 1
      @options[:finish].call if @options[:finish]
      Game.state.remove self
    else
      @action.call(@function[@p])
    end
  end
  
  FUNCTIONS={
    :in   =>lambda{|p| p},
    :out  =>lambda{|p| 1-p}
  }
end