class WordControl < AbstractButton
  attr_accessor :word, :width, :height
  attr_reader :command
  include Colored
  
  TEXT_COLOR =  Gosu::Color.new 0x996666FF
  VALID_COLOR = Gosu::Color.new 0xCC66FF66
  INVALID_COLOR = Gosu::Color.new 0xCCFF6666
  
  def initialize(word, status)
    @height = 64
    @font = Game.load_font 'Helvetica', @height
    @click_handler = ClickHandler.new{|x,y, button| clicked(x,y, button) }
    self.word = word
    self.color = TEXT_COLOR
    @status = status
  end
  
  def x
    Game.window.width/2 - @width/2
  end
  
  def y
    256
  end
  
  def word= new_word
    @width = @font.text_width(new_word)
    cumulative = 0
    @char_offsets = new_word.chars.map do |c| 
      w = @font.text_width(c) 
      cumulative += w
    end
    
    @selected_index = nil
    @command = nil
    @base_word = new_word.clone
    @word = new_word
  end
  
  def reset
    puts "resetting: #{@word} => #{@base_word}"
    self.word = @base_word
  end
  
  def update
    if !has_command?
      self.color = TEXT_COLOR
    else
      self.color = valid? ? VALID_COLOR : INVALID_COLOR
    end
  end
  
  # Returns whether to swallow the event
  def button_up(id)
    super(id)
    
    # if letter pressed
    if letter = Game.window.button_id_to_char(id)
      letter_pressed(letter)
    end
    
    if id == Gosu::KbSpace
      self.reset
    end
  end
  
  def clicked(x,y, button)
    index = nil
    
    @char_offsets.each_with_index do |offset, i|
      if self.x+offset > x
        index = i
        break
      end
    end
    
    if index
      select_char(index)
    end
  end
  
  def has_command?
    !!@command
  end
  
  # Select a character.
  # Clicking the same index again deselects it
  def select_char(index)
    if @selected_index != index
      if @selected_index
        self.command = SwapCommand.new(@word, @selected_index, index)      
      end
      @selected_index = index
    else
      @selected_index = nil
    end
  end
  
  # Selecting a letter.
  def letter_pressed(letter)
    if @selected_index
      self.command = ReplaceCommand.new(@word, @selected_index, letter.downcase)
    end
  end
  
  def command= new_command
    if !has_command?
      @command = new_command
      @word = @command.word
      @status.text = new_command.describe
      @valid = validate @command.word
    end
  end
  
  def validate(word)
    true
  end
  
  def valid?
    @valid
  end
  
  def draw
    @font.draw(@word, x , y , Layers::UI, 1, 1, @color, :default)
    
    if @selected_index
      top = y
      bottom = y + height
      left = x + [0, *@char_offsets][@selected_index] - 3
      right = x + @char_offsets[@selected_index] + 3
      bg_color = 0xCCFFFFFF
      Game.window.draw_quad(
        left, top,      bg_color, 
        right, top,     bg_color, 
        left, bottom,   bg_color, 
        right, bottom,  bg_color, 
        Layers::BACKGROUND, :default)
    end
  end
end  