class Container
  def initialize
    @drawables = []
    @updatables = []
    @listenables = []
  end
  
  def add(managed_object)
    @drawables    << managed_object if managed_object.respond_to?(:draw)
    @updatables   << managed_object if managed_object.respond_to?(:update)
    @listenables  << managed_object if managed_object.respond_to?(:button_up)
    managed_object
  end
  
  def remove(managed_object)
    [@drawables, @updatables, @listenables].each{|list| list.delete(managed_object) }
    managed_object
  end
  
  def update
    @updatables.each{|o| o.update}
  end
  
  def draw
    @drawables.each{|o| o.draw}
  end
  
  def button_up(id)
    @listenables.each{|o| o.button_up(id)}
  end
end