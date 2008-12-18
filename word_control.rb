class WordControl < GameObject
  attr_accessor :word, :width, :height
  include Colored
  include Positioned
  
  TEXT_COLOR =  Gosu::Color.new 0x666666FF
  HIGHLIGHTED = Gosu::Color.new 0xCC6666FF
  
  def initialize(word)
    @height = 48
    @font = Game.load_font 'Helvetica', @height
    self.word = word
    self.color = TEXT_COLOR
  end
  
  def word= new_word
    @width = @font.text_width(new_word)
    @word = new_word
  end
  
  def x
    Game.window.width/2 - @width/2
  end
  
  def y
    256
  end
  
  def update
    if mouse_within?
      self.color = HIGHLIGHTED
    else
      self.color = TEXT_COLOR
    end
  end
  
  def draw
    @font.draw(@word, x , y , Layers::UI, 1, 1, @color, :default)
  end
end  