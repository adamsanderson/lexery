class Button
  HOVER_COLOR_1 = Gosu::Color.new 0x116666FF
  HOVER_COLOR_2 = Gosu::Color.new 0x0
  
  include Positioned
  include Publisher
  events :click
  
  attr_reader :x, :y, :width, :height, :text, :action
  
  def initialize(x,y, text, options={}, &action)
    super()
    
    @x = x
    @y = y
    @text = text
    
    subscribe(:click, self, &action) if block_given?
    
    @height = options[:height]  || 32
    @font =   options[:font]    || Game.load_font(:default, @height - 4)
    @width =  options[:width]   || @font.text_width(@text) + 4
    
    @color = options[:color]    || 0x666666CC
  end
    
  def draw
    @font.draw(text, x , y , Layers::UI, 1, 1, @color, :default)
    if mouse_within?
      Game.window.draw_quad(
        x-4, y-4,             HOVER_COLOR_1, 
        x+width, y-4,         HOVER_COLOR_1, 
        x-4, y+height,        HOVER_COLOR_2, 
        x+width, y+height,    HOVER_COLOR_2)
    end
  end
  
  def button_up(id)
    if mouse_within? and mouse_click?(id)
      fire_event :click, Game.window.mouse_x, Game.window.mouse_y, id
    end
  end
  
  def mouse_click?(id)
    id == Gosu::MsLeft || id == Gosu::MsMiddle || id == Gosu::MsRight
  end
end