# Requires Positioned's support methods
class AbstractButton < GameObject
  include Positioned
  
  def initialize
    @click_handler = ClickHandler.new{|x,y, button| clicked(x,y, button) }
  end
  
  def update
  end
  
  def draw
  end
  
  def button_up(id)
    if mouse_within?
      @click_handler.click(id)
      true
    end
  end
  
  def clicked(x,y,button)
    
  end
end