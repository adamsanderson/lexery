class WordControl < GameObject
  attr_accessor :word, :width, :height
  include Colored
  include Positioned
  
  TEXT_COLOR =  Gosu::Color.new 0x666666FF
  HIGHLIGHTED = Gosu::Color.new 0xCC6666FF
  
  def initialize(word)
    @height = 64
    @font = Game.load_font 'Helvetica', @height
    @click_handler = ClickHandler.new{|x,y, button| clicked(x,y, button) }
    self.word = word
    self.color = TEXT_COLOR
  end
  
  def word= new_word
    @width = @font.text_width(new_word)
    cumulative = 0
    @char_offsets = new_word.chars.map do |c| 
      w = @font.text_width(c) 
      cumulative += w
    end
    
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
  
  # Returns whether to swallow the event
  def button_up(id)
    if mouse_within?
      @click_handler.click(id)
      true
    end
  end
  
  def clicked(x,y, button)
    puts "#{x},#{y}, #{button}"
    index = 0
    @char_offsets.each_with_index do |offset, i|
      puts offset
      if self.x+offset > x 
        index = i
        break
      end
    end
    
    @selected_index = index
    puts "index: #{@selected_index}, '#{@word.chars[@selected_index]}'"
  end
  
  def draw
    @font.draw(@word, x , y , Layers::UI, 1, 1, @color, :default)
  end
end  