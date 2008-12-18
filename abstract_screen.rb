class AbstractScreen
  attr_reader :window
  
  def initialize
    @window = Game.window
    @@cursor ||= Game.load_image("cursor.png", false)
  end
  
  def update
  end
  
  def draw
    @@cursor.draw(window.mouse_x, window.mouse_y, Layers::CURSOR) if cursor_visible?
  end
  
  def button_down(id)
  end
  
  def button_up(id)
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
