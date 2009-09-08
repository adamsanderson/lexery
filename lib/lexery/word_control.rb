class WordControl < Gosu::TextInput
  attr_accessor :x, :y
  attr_accessor :word, :width, :height
  attr_reader   :command
  attr_accessor :valid
  
  include Positioned
  
  CARET_COLOR     = Gosu::Color.new 0x996666FF
  TEXT_COLOR      = Gosu::Color.new 0x996666FF
  VALID_COLOR     = Gosu::Color.new 0xCC66DD66
  INVALID_COLOR   = Gosu::Color.new 0xCCFF6666
  SELECTION_COLOR = Gosu::Color.new 0x330000FF
  
  def initialize(x,y,word)
    super()
    
    @height = 64
    @font = Game.load_font :default, @height
    self.word = word
    self.text = word

    @x = x
    @y = y
    
    Game.window.text_input = self
  end
  
  def text
    (super || '').downcase
  end
      
  def word= new_word
    @width = @font.text_width(new_word)
    @word = new_word
    @valid = false
  end
  
  def reset
    self.text = @word
  end
   
  def update
    
  end
  
  def draw
    # Calculate the position of the caret and the selection start.
    pos_x = x + @font.text_width(self.text[0...self.caret_pos])
    sel_x = x + @font.text_width(self.text[0...self.selection_start])
    
    # Draw the selection background, if any; if not, sel_x and pos_x will be
    # the same value, making this quad empty.
    Game.window.draw_quad(sel_x, y,          SELECTION_COLOR,
                      pos_x, y,          SELECTION_COLOR,
                      sel_x, y + height, SELECTION_COLOR,
                      pos_x, y + height, SELECTION_COLOR,
                      Layers::UI)
    
    Game.window.draw_line(pos_x, y,          CARET_COLOR,
                      pos_x, y + height, CARET_COLOR, 
                      Layers::UI)

    if self.word == self.text
      color = TEXT_COLOR
    else
      color = valid ? VALID_COLOR : INVALID_COLOR
    end
    
    @font.draw(self.text, x , y , Layers::UI, 1, 1, color, :default)
  end
end  