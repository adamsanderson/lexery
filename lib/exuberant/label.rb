class Label
  attr_accessor :x, :y, :width, :height, :text, :color
  include Positioned
  
  def initialize(x,y, text=nil, options={}, &block)
    super()
     if text.is_a?(Hash)
       options = text
       text = ''
     end
    
    @x = x
    @y = y
    @options = options
    
    @height = options[:height]  || 32
    @font =   options[:font]    || Game.load_font(:default, @height - 4)
    @width =  options[:width]   || @font.text_width(@text) + 4
    
    self.text = text
    @block = block if block_given?
    
    @color = options[:color]    || Gosu::Color.new(0x66666666)
  end
  
  def text= new_text
    if new_text != @text
      @text = new_text
      @width = @font.text_width(@text) + 4 unless @options[:width]
    end
  end
  
  def update
    self.text = @block.call if @block
  end
  
  def draw
    @font.draw(text, x , y , Layers::UI, 1, 1, @color, :default)
  end
end