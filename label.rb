class Label
  attr_reader :x, :y, :width, :height, :text
  attr_writer :x, :y
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
    @font =   options[:font]    || Game.load_font('Helvetica', @height - 4)
    @width =  options[:width]   || @font.text_width(@text) + 4
    
    self.text = text
    @block = block if block_given?
    
    @color = options[:color]    || 0x66666666
    
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