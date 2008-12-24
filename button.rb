class Button < AbstractButton
  attr_reader :x, :y, :width, :height, :label
  
  def initialize(x,y, label, options={}, &action)
    super()
    
    @x = x
    @y = y
    @label = label
    @action = action
    
    @height = options[:height]  || 32
    @font =   options[:font]    || Game.load_font('Helvetica', @height - 4)
    @width =  options[:width]   || @font.text_width(@label) + 4
    
    @color = options[:color]    || 0x66666666
  end
  
  def clicked(x,y, button)
    @action.call(x,y, button)
  end
  
  def draw
    @font.draw(label, x , y , Layers::UI, 1, 1, @color, :default)
  end
end