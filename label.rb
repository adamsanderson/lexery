class Label
  attr_reader :x, :y, :width, :height, :text
  include Positioned
  
  def initialize(x,y, text, options={})
    super()
    
    @x = x
    @y = y
    @text = text
    
    @height = options[:height]  || 32
    @font =   options[:font]    || Game.load_font('Helvetica', @height - 4)
    @width =  options[:width]   || @font.text_width(@text) + 4
    
    @color = options[:color]    || 0x66666666
    @options = options
  end
  
  def text= new_text
    @text = new_text
    @width = @font.text_width(@text) + 4 unless @options[:width]
  end
  
  def update
  end
  
  def draw
    @font.draw(text, x , y , Layers::UI, 1, 1, @color, :default)
  end
end