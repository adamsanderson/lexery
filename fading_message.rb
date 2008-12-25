class FadingMessage
  include Positioned
  attr_reader :x, :y, :width, :height, :text
  
  def initialize(x,y, text, options={}, &action)
    super()
    
    @x = x
    @start_y = @y = y
    
    @text = text
    
    @height = options[:height]  || 32
    @font =   options[:font]    || Game.load_font('Helvetica', @height - 4)
    @width =  options[:width]   || @font.text_width(@text) + 4
    @color =  options[:color]   || Gosu::Color.new(0xCC6666FF)
    
    @duration = options[:duration] || 3000 # 3 seconds
    @target_y = 0 - @height
    @started = Gosu::milliseconds
    @p = 1
  end
  
  def update
    @p = 1 - (Gosu::milliseconds - @started)/(@duration.to_f)
    @y = @target_y + (@start_y - @target_y) * @p

    return @p > 0
  end
  
  def draw
    color = Gosu::Color.new(
      (@color.alpha*@p).to_i, 
      @color.red,
      @color.green,
      @color.blue
    )
    @font.draw(text, x , y , Layers::UI, 1, 1, color, :default)
  end
  
end