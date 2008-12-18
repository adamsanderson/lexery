# Expects x,y,width,height
module Positioned
  def mouse_within?
    within? Game.window.mouse_x, Game.window.mouse_y
  end
  
  def within?(x,y)
    self.x <= x and 
    self.y <= y and
    self.x+width > x and
    self.y+height > y
  end
end