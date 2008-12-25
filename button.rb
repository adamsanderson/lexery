class Button < AbstractButton
  attr_reader :x, :y, :width, :height, :text, :action
  
  def initialize(x,y, text, options={}, &action)
    super()
    
    @x = x
    @y = y
    @text = text
    
    @action = action if block_given?
    
    @height = options[:height]  || 32
    @font =   options[:font]    || Game.load_font('Helvetica', @height - 4)
    @width =  options[:width]   || @font.text_width(@text) + 4
    
    @color = options[:color]    || 0x66666666
  end
  
  def clicked(x,y, button)
    @action.call(x,y, button) if @action
  end
  
  def draw
    @font.draw(text, x , y , Layers::UI, 1, 1, @color, :default)
  end
end