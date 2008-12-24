# Expects x,y,width,height
module Positioned
  def mouse_within?
    within? Game.window.mouse_x, Game.window.mouse_y
  end
  
  def top
    y
  end
  
  def bottom
    y + height
  end
  
  def left
    x
  end
  
  def right
    x + width
  end
  
  def within?(x,y)
    left    <= x and 
    top     <= y and
    right   > x and
    bottom  > y

  end
end