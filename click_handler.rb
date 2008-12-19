class ClickHandler
  def initialize(&handler)
    @handler = handler
  end
  
  def click(id)
    if mouse_click?(id)
      @handler.call(Game.window.mouse_x, Game.window.mouse_y, id)
    end
  end
  
  def mouse_click?(id)
    id == Gosu::MsLeft || id == Gosu::MsMiddle || id == Gosu::MsRight
  end
end