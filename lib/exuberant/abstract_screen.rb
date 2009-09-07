class AbstractScreen < Container
  attr_reader :window
  
  def initialize
    super
    @window = Game.window
    @@cursor ||= Game.load_image("cursor.png", false)
  end
  
  def draw
    super
    
    @@cursor.draw(window.mouse_x, window.mouse_y, Layers::CURSOR) if cursor_visible?
    window.draw_quad(
      0, 0,         Colors::BACKGROUND_TOP, 
      width, 0,     Colors::BACKGROUND_TOP, 
      0, height,    Colors::BACKGROUND_BOTTOM,
      width, height,Colors::BACKGROUND_BOTTOM
    )
  end
  
  def button_down(id)
  end
  
  protected
  def width
    Game.window.width
  end
  
  def height
    Game.window.height
  end
  
  def cursor_visible?
    true
  end
end
