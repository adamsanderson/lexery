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
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
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
