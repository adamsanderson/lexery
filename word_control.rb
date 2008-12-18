class WordControl < GameObject
  attr_accessor :word
  
  def initialize(word)
    @word = word
    @font = Game.load_font 'Helvetica', 48
  end
  
  def update
    
  end
  
  def draw
    @font.draw_rel(@word, Game.window.width/2, 256, Layers::UI, 0.5, 0, 1, 1, 0x666666FF, :default)
  end
end  