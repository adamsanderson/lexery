class AbstractScreen
  attr_reader :window
  
  def initialize
    @window = Game.window
    @@cursor ||= Game.load_image("cursor.png", false)

    @drawers = []
    @updaters = []
    @listeners = []
  end
  
  def add(managed_object)
    @drawers    << managed_object if managed_object.respond_to?(:draw)
    @updaters   << managed_object if managed_object.respond_to?(:update)
    @listeners  << managed_object if managed_object.respond_to?(:button_up)
    managed_object
  end
  
  def remove(managed_object)
    [@drawers, @updaters, @listeners].each{|list| list.delete(managed_object) }
    managed_object
  end
  
  def update
    @updaters.each{|o| o.update}
  end
  
  def draw
    @@cursor.draw(window.mouse_x, window.mouse_y, Layers::CURSOR) if cursor_visible?
    window.draw_quad(0, 0, 0xffffffff, width, 0, 0xffffffff, 0, height, 0xFFF7D9FF, width, height, 0xFFF7D9FF)
    
    @drawers.each{|o| o.draw}
  end
  
  def button_down(id)
  end
  
  def button_up(id)
    @listeners.each{|o| o.button_up(id)}
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
